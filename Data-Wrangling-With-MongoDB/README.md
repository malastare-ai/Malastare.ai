## Data Wrangling with MongoDB

# Step 1 : The Data Set

> * Map Area : Mumbai, India
> * Source : http://www.openstreetmap.org/
> * File Sizes : 
>              Compressed   : 6.5MB
>              , Uncompressed : 92MB


## _Importing the dataset location_

```python
import xml.etree.cElementTree as ET
from pprint import pprint

mumbai_file = "../Data sets/mumbai.osm"
```

# Step 2 : Checking for problems and inconsistency in the data


> Finding the types of Parent Tags

```python
root_types = {}

for event, element in ET.iterparse(mumbai_file):
    if element.tag == "osm":
        for child in element:
            if child.tag not in root_types:
                root_types[child.tag] = 1
            else:
                root_types[child.tag] += 1
pprint(root_types)
```

    {'bounds': 1, 'node': 470060, 'relation': 126, 'way': 40396}
    
> Here we see that there a broadly four types of tags: nodes, way, relation and bounds
> Since number of bounds and relations are far lesser, we need to explore nodes and ways thoroughly

```python
from collections import defaultdict

sub_types = defaultdict(lambda : defaultdict(set))

for event, element in ET.iterparse(mumbai_file):
    if element.tag in root_types:
        for child in element:
            for attribute in child.attrib:
                sub_types[element.tag][child.tag].add(attribute)

for types in root_types:
    print types, sub_types[types]
```

    node defaultdict(<type 'set'>, {'tag': set(['k', 'v'])})
    relation defaultdict(<type 'set'>, {'member': set(['role', 'ref', 'type']), 'tag': set(['k', 'v'])})
    bounds defaultdict(<type 'set'>, {})
    way defaultdict(<type 'set'>, {'tag': set(['k', 'v']), 'nd': set(['ref'])})
    
> Further, we look upon the various child tags present in the root tags we saw in the previous code snippet's result.
> The only thing left now is to check for characters that can cause problem and modify those names to shape our data.

### _Fields with sub-fields and problematic characters_

```python
import re


lower = re.compile(r'^([a-z]|_)*$')
lower_colon = re.compile(r'^([a-z]|_)*:([a-z]|_)*$')
problemchars = re.compile(r'[=\+/&<>;\'"\?%#$@\,\. \t\r\n]')

keys = {'lower' : 0, 'lower_colon' : 0, 'problemchars' : 0, 'other' : 0}

for event, element in ET.iterparse(mumbai_file):
    if element.tag == 'tag':
        d = element.attrib['k']
        flag = 0
        if(re.match(lower,d)):
            keys['lower']+=1
            flag = 1
        elif(re.match(lower_colon,d)):
            keys['lower_colon']+=1
            flag = 1
        
        if flag==0:
            for c in d:
                if(re.match(problemchars, c)):
                    keys['problemchars']+=1
                    flag = 2
                    print d
                    break
                    
        if flag ==0:
            keys['other'] +=1
        

pprint(keys)
```

    Cable TV Provider
    EState Consultants
    Sahakari Bhandar
    business Park
    business Park
    Mangeshi Dham
    street parking
    street parking
    street parking
    street parking
    street parking
    street parking
    street parking
    Community Centre
    Area details 
    street parking
    street parking
    Golden Park
    maneshi dham
    mangeshi dham
    {'lower': 108481, 'lower_colon': 3270, 'other': 842, 'problemchars': 20}
    
> There isn't any problematic character except the 'space' character, which is not much of a concern. The only point of interest is the ':' character which means the presence of sub fields.

### _A final check on the field names to view all the field names and make decisons for cleaning accordingly_

```python
list_of_keys = set()

for event, element in ET.iterparse(mumbai_file):
    if element.tag in ["node", "way"]:
        for child in element:
            try:
                list_of_keys.add(child.attrib['k'])
            except:
                pass

pprint(list_of_keys)
        
```

    set(['AND:importance_level',
         'AND_a_c',
         'AND_a_i',
         'AND_a_nosr_p',
         'AND_a_nosr_r',
         'AND_a_w',
         'AREA',
         'Amenity',
         'Area details ',
         'Cable TV Provider',
         -
         -
         ---------OUTPUT HIDDEN---------

    
> As we notice, there are a few abbreviated field names and some have been repeated like addr:postcode and postcode, which need to be taken care of.

### _Scanning Amenities for checking consistency in field type_

```python
list_of_amenities = set()

for event, element in ET.iterparse(mumbai_file):
    if element.tag in ["node", "way"]:
        for child in element:
            try:
                if "amenity" in child.attrib['k']:
                    list_of_amenities.add(child.attrib['v'])
                if "Amenity" in child.attrib['k']:
                    list_of_amenities.add(child.attrib['v'])
            except:
                pass
           

pprint(list_of_amenities)
```

    set(['Canteen',
         'Educational Complex',
         'Gym',
         'Gymkhana',
         'Society',
         'Workshop
         -
         -
         ---------OUTPUT HIDDEN---------
    
> We notice that there are a few entries where there are multiple input values in the form of ';' seperated values.

### _Mapping correct names for fields having sub fields._

```python
keys_with_sub_types = {}
keys_with_sub_types_set = set()

for event, element in ET.iterparse(mumbai_file):
    if element.tag in root_types:
        for child in element:
            try:
                if ':' in child.attrib['k']:
                    parent = child.attrib['k'].split(':')[0]
                    if parent not in keys_with_sub_types:
                        keys_with_sub_types[parent] = parent
                        keys_with_sub_types_set.add(parent)
            except:
                pass

pprint(keys_with_sub_types)
```

    {'AND': 'AND',
     'addr': 'addr',
     'building': 'building',
     'fuel': 'fuel',
     'gns': 'gns',
     'internet_access': 'internet_access',
     'is_in': 'is_in',
     'name': 'name',
     'oneway': 'oneway',
     'payment': 'payment',
     'place': 'place',
     'ref': 'ref',
     'seamark': 'seamark',
     'ship': 'ship',
     'shop': 'shop',
     'source': 'source',
     'tower': 'tower',
     'turn': 'turn',
     'wp': 'wp'}
    
> all abbreviations shall be converted to their full names

```python
keys_with_sub_types['addr'] = "address"
keys_with_sub_types['gns']  = "GEOnet Name Server"
keys_with_sub_types['is_in'] = "located_in"
keys_with_sub_types['ref'] = "reference"
pprint(keys_with_sub_types)
```

    {'AND': 'AND',
     'addr': 'address',
     'building': 'building',
     'fuel': 'fuel',
     'gns': 'GEOnet Name Server',
     'internet_access': 'internet_access',
     'is_in': 'located_in',
     'name': 'name',
     'oneway': 'oneway',
     'payment': 'payment',
     'place': 'place',
     'ref': 'reference',
     'seamark': 'seamark',
     'ship': 'ship',
     'shop': 'shop',
     'source': 'source',
     'tower': 'tower',
     'turn': 'turn',
     'wp': 'wp'}

> The 'keys_with_sub_types' variable contains the correct name for each of the fields which contain multiple sub fields.

### _Understanding the name field_

```python
languages_mapping = {}
languages = []

for event, element in ET.iterparse(mumbai_file):
    if element.tag in root_types:
        for child in element:
            try:
                if ':' in child.attrib['k']:
                    parent_field = child.attrib['k'].split(':')[0]
                    sub_field = child.attrib['k'].split(':')[1]
                    if parent_field == "name":
                        if sub_field not in languages:
                            languages_mapping[sub_field] = sub_field
                            languages.append(sub_field)
        
            except:
                pass
    
pprint(sorted(languages))
```

    ['',
     'bn',
     'cs',
     'de',
     'en',
     'es',
     'fr',
     'gu',
     'hi',
     'jbo',
     'kn',
     'ma',
     'mr',
     'pl',
     'pt',
     'ru',
     'sk',
     'sr',
     'ta',
     'te']
    
> The name field also has sub fields which include names in various other languages, the language codes can be converted to their respective language names.

```python
languages_replace = ["other","bengali","czech","german","english","spanish","french","gujrati","hindi","lobjan","kanada","arabic","marathi","polish","portuguese","russian","slovak","serbian","tamil", "telugu"]
counter = 0

for language in sorted(languages):
    languages_mapping[language] = languages_replace[counter]
    counter += 1

pprint(languages_mapping)
```

    {'': 'other',
     'bn': 'bengali',
     'cs': 'czech',
     'de': 'german',
     'en': 'english',
     'es': 'spanish',
     'fr': 'french',
     'gu': 'gujrati',
     'hi': 'hindi',
     'jbo': 'lobjan',
     'kn': 'kanada',
     'ma': 'arabic',
     'mr': 'marathi',
     'pl': 'polish',
     'pt': 'portuguese',
     'ru': 'russian',
     'sk': 'slovak',
     'sr': 'serbian',
     'ta': 'tamil',
     'te': 'telugu'}
    
> Language mapping variable contains the name of language for its short code.

### _Postcodes_

```python
postal_code = set()
postcode = set()

for event, element in ET.iterparse(mumbai_file):
        for child in element:
            try:
                if child.attrib['k'] == "postal_code":
                    postal_code.add(child.attrib['v'])
                if child.attrib['k'] == "addr:postcode":
                    postcode.add(child.attrib['v'])
                    
            except:
                pass

pprint(postal_code)
pprint(postcode)
```

    set(['400001',
         -
         -
         ---------OUTPUT HIDDEN---------',
         '400 022',
         '400 601',
        -
         -
         ---------OUTPUT HIDDEN---------
         '400076',
         '400076, India',
         '400077',
         -
         -
         ---------OUTPUT HIDDEN---------
    

>  Problems in Postcode variables <br/>
> 1. codes seperated by space in some cases <br/>
> 2. codes contain alphabets in some cases  <br/>
> 3. multiple keys where postal codes can be found : addr:postcode, postal_code and postcode <br/>


# Step 3: Shaping data into Python Dictionary

<br/>
<br/>

### _Desired structure of the dictionary:_

<br/>
<br/>
```python  
  { 
      id : , 
      type : , 
      visible : , 
      created : { 
                 version : , 
                 changeset : , 
                 timestamp : , 
                 user : , 
                 uid : 
               }, 
      pos : [latitude, longitude], 
      address : { 
                 housenumber: , 
                 postcode : , 
                 street : 
                }, 
      amenity : , 
      cuisine : , 
      name : , 
      phone : , 
      . 
      . 
      _other fields_ 
      . 
      . 
    }
    
```

> Now we can start putting the data from xml to a python dictionary and then make a list of dictionaries that can be stored into a json file. While creating the dictionary, we shall take care of the problems we detected earlier.

```python


def shape_data(elements , current_dict):
    
                                       #Head tags, decide the type of entry
    if elements.tag in ["node","way"]:                             
        current_dict['type'] = elements.tag
        
        
                                      
                                      # created field extracted from attributes of head tag
        current_dict['created'] = {}                               
        if 'lat' in elements.attrib and 'lon' in elements.attrib: 
            current_dict['pos']  =  [float(elements.attrib['lat']), float(elements.attrib['lon'])]
            
                                       
                                       # Other attributes contained in the head tag are added to the dictionary
        for attribute in elements.attrib:
            if attribute not in ["lat", "lon", "user", "uid", "timestamp", "changeset", "version"]:
                current_dict[attribute] = elements.attrib[attribute]
            elif attribute in ["user", "uid", "timestamp", "changeset", "version"]:
                current_dict['created'][attribute] = elements.attrib[attribute]
    
                              
    #'nd' tag of the way type of head tags are found and its ref attribute is added to the dictionary in a list
    if elements.tag == "nd":
        if 'nd_ref' not in current_dict:
            current_dict['nd_ref'] = []
        if 'ref' in elements.attrib:    
            current_dict['nd_ref'].append(elements.attrib['ref'])
    
    
    # Child tags containing head tag as 'tag' are scanned one by one
    for element in elements:
                                                    
        if element.tag == "tag":
                                                    
            # Amentities are converted to a list as some contain multiple 
            if element.attrib['k'] in ["Amenity","amenity"]:
                if ';' in element.attrib['v']:
                    values = element.attrib['v'].split(';')
                    current_dict['amenity'] = values
                else:
                    current_dict['amenity'] = [element.attrib['v']]  
                                
            
            #  Postal code is a duplicate field, it is inserted into the address field                                         
            elif element.attrib['k'] == "postal_code":
                    if 'address' not in current_dict:
                        current_dict[address] = {}
                        current_dict['address']['postcode'] = int(element.attrib['v'])

            # another duplicate field for addr:postcode                                      
            elif element.attrib['k'] == "postcode":
                if 'address' not in current_dict:
                        current_dict[address] = {}
                current_dict['address']['postcode'] = int(element.attrib['v'])

            # Fields containing sub fields are scanned                                      
            elif ':' in element.attrib['k']:
                
                 # split the name by ':' to get the parent field and its sub field
                splitted_fields = element.attrib['k'].split(':')  
                parent = splitted_fields[0]

                # If parent field isn't present inintialise
                # it as an empty dictionary
                # Abbreviated names are changed to their full
                # names from keys_with_sub_types variable
                if keys_with_sub_types[parent] not in current_dict:  
                    current_dict[keys_with_sub_types[parent]] = {}
                elif type(current_dict[keys_with_sub_types[parent]]) != type({}):      
                    value = current_dict[keys_with_sub_types[parent]]                  
                    current_dict[keys_with_sub_types[parent]] = {}                     
                    current_dict[keys_with_sub_types[parent]][parent] = value          
                
                if parent == "addr" and element.attrib('k').split(':')[1] == "postcode":
                    
                    current_dict[keys_with_sub_types[parent]]['postcode'] = element.attrib('v').strip(' ').split(',')[0]
                    
                
                # If the parent field is name, get its
                # sub field and insert with suitable full name of 
                # the language from language_mapping variable
                elif parent == "name":
                    sub_name = splitted_fields[1]
                    current_dict[keys_with_sub_types[parent]][languages_mapping[sub_name]] = element.attrib['v']

                elif len(splitted_fields) > 2:
                    temp_dict  = {}
                    temp_dict1 = {}
                    temp_dict1[splitted_fields[-1]] = element.attrib['v']             
                                                                                       
                    for i in range(2,len(splitted_fields)):                            
                        temp_dict[splitted_fields[-1*i]] = temp_dict1
                        temp_dict1 = temp_dict

                    current_dict[keys_with_sub_types[parent]] = temp_dict

                else:
                    current_dict[keys_with_sub_types[parent]][splitted_fields[1]] = element.attrib['v']
            
            # for any other parent field insert with suitable
            # corrections from keys_with_sub_types
            else:
                attribute = element.attrib['k']
                attribute = attribute.lower()
                try:
                    if type(current_dict[attribute]) == type({}):                       
                        current_dict[attribute][attribute] = element.attrib['v']        
                    else:
                        current_dict[attribute] = element.attrib['v']
                except:
                    current_dict[attribute] = element.attrib['v']

                
    return current_dict



def create_dictionary(mumbai_file):
    
    json_list = []
    current_dict = {}
    
    for event, element in ET.iterparse(mumbai_file):
        
        # as soon as new node/way is detected append the current dictionary
        # and clear it fit the contents of the new node/way.
        if element.tag in ["node", "way"]:
            json_list.append(current_dict)                  
            current_dict = {}                               
            current_dict = shape_data(element, current_dict)
        elif element.tag not in ["relation", "bounds"]:
            current_dict = shape_data(element, current_dict)
            
    return json_list

final_dictionary = create_dictionary(mumbai_file)
print "Done"
```

    Done
    
### _Save the list of dictionaries to a json file_

```python
import json
with open('data.json', 'w') as file:
    json.dump(final_dictionary, file)
```

### _Comparing sizes of the file before and after_

```python
import os

print "Size of Json File: " ,(os.path.getsize('data.json'))/(1024*1024) , "MB"
print "Size of uncompressed osm File : ", (os.path.getsize(mumbai_file))/(1024*1024) , "MB"
```

    Size of Json File:  105 MB
    Size of uncompressed osm File :  92 MB
    
# Step 4: Inserting into MongoDB and data overview

```python
import pymongo

connection = pymongo.MongoClient("mongodb://localhost")

db = connection.osm_data

record = db.mumbai_data

mumbai_data = open('data.json', 'r')

parsed_mumbai_data = json.loads(mumbai_data.read())

for entry in parsed_mumbai_data:
    record.insert_one(entry)
```

## _Overview of the data_

> Objects in MongoDB

```python
record.find().count()
```




    510456


> Dictionaries in the list

```python
len(parsed_mumbai_data)
```




    510456


### _Number of Nodes and Ways_

```python
entry_types_count = record.aggregate([{"$match": {"type": {"$in": ["node","way"]}}},{ "$group" : {"_id": "$type", "count" : {"$sum": 1} }}])

pprint(list(entry_types_count))
```

    [{u'_id': u'node', u'count': 470053}, {u'_id': u'way', u'count': 40213}]
    
### _Number of distinct users_

```python
pprint(len(list(record.distinct('created.user'))))
```

    455
    

# Step 5: Further exploration of data using MongoDB
<br/> <br/>
### _Top 20 Contributers_
```python
user_contributions = record.aggregate([{"$match": {"created.user": {"$exists": 1}}},
                                       {"$group": {"_id" : "$created.user", "count": {"$sum": 1}}},
                                      {"$sort": {"count" : -1}},
                                      {"$limit": 20}])
pprint(list(user_contributions))
```

    [{u'_id': u'PlaneMad', u'count': 65571},
     {u'_id': u'MJL Wood', u'count': 61257},
     {u'_id': u'balaji88', u'count': 59941},
     {u'_id': u'parambyte', u'count': 45287},
     {u'_id': u'udaya', u'count': 44663},
     {u'_id': u'smith_dsm', u'count': 39375},
     {u'_id': u'Giyavudeen', u'count': 30007},
     {u'_id': u'indigomc', u'count': 19682},
     {u'_id': u'shekhar', u'count': 13296},
     {u'_id': u'Moorthy1', u'count': 11864},
     {u'_id': u'singleton', u'count': 10324},
     {u'_id': u'PremK', u'count': 10180},
     {u'_id': u'dmgroom_coastlines', u'count': 7880},
     {u'_id': u'gaurav jain', u'count': 7754},
     {u'_id': u'Heinz_V', u'count': 6907},
     {u'_id': u'Oberaffe', u'count': 6393},
     {u'_id': u'Meghanand', u'count': 6135},
     {u'_id': u'Shekhar11', u'count': 4717},
     {u'_id': u'jain zachariah', u'count': 4545},
     {u'_id': u'katpatuka', u'count': 4402}]

> We can see a highly skewed distribution in terms of contribution

    
### _List of Cuisines in Mumbai_

```python
pprint(list(record.aggregate([{"$match": {'cuisine': {"$exists": 1}}},
                         {"$group": {'_id': "$cuisine", "count" : {"$sum": 1}}}])))
```

    [{u'_id': u'italian', u'count': 5},
     {u'_id': u'indian', u'count': 30},
     {u'_id': u'coffee_shop', u'count': 26},
     {u'_id': u'mediterranean', u'count': 1},
     {u'_id': u'burger', u'count': 12},
     {u'_id': u'pizza', u'count': 10},
     {u'_id': u'persian', u'count': 1},
     {u'_id': u'vegetarian', u'count': 14},
     {u'_id': u'seafood', u'count': 2},
     {u'_id': u'sandwich', u'count': 4},
     {u'_id': u'regional', u'count': 3},
     {u'_id': u'chinese', u'count': 7},
     {u'_id': u'chicken', u'count': 2},
     {u'_id': u'american', u'count': 2},
     {u'_id': u'ice_cream', u'count': 2},
     {u'_id': u'asian', u'count': 1},
     {u'_id': u'international', u'count': 5},
     {u'_id': u'thai', u'count': 1},
     {u'_id': u'spanish', u'count': 1},
     {u'_id': u'sad_food', u'count': 1},
     {u'_id': u'Goan', u'count': 1}]
     
> The numbers although aren't enough to draw conclusions, but it's still not a matter of surprise
that Indian cuisine is the highest in number.
    
### _Top 20 Amenities in Mumbai_

```python
pprint(list(record.aggregate([{"$match": {'amenity': {"$exists": 1}}},
                         {"$group": {'_id': "$amenity", "count" : {"$sum": 1}}},
                             {"$sort":{"count": -1}},
                             {"$limit": 20}])))
```

    [{u'_id': [u'place_of_worship'], u'count': 246},
     {u'_id': [u'school'], u'count': 211},
     {u'_id': [u'restaurant'], u'count': 161},
     {u'_id': [u'bank'], u'count': 134},
     {u'_id': [u'parking'], u'count': 117},
     {u'_id': [u'hospital'], u'count': 110},
     {u'_id': [u'bus_station'], u'count': 102},
     {u'_id': [u'fuel'], u'count': 100},
     {u'_id': [u'college'], u'count': 83},
     {u'_id': [u'fast_food'], u'count': 66},
     {u'_id': [u'police'], u'count': 57},
     {u'_id': [u'cafe'], u'count': 55},
     {u'_id': [u'atm'], u'count': 51},
     {u'_id': [u'cinema'], u'count': 50},
     {u'_id': [u'swimming_pool'], u'count': 48},
     {u'_id': [u'post_office'], u'count': 40},
     {u'_id': [u'pharmacy'], u'count': 36},
     {u'_id': [u'toilets'], u'count': 35},
     {u'_id': [u'marketplace'], u'count': 27},
     {u'_id': [u'public_building'], u'count': 22}]
    
> Its quite surprising that there are so many places of worship!, other figures are as expected.


### _Top 10 types of buildings in Mumbai_

```python
pprint(list(record.aggregate([{"$match": {'building': {"$exists": 1}}},
                         {"$group": {'_id': "$building", "count" : {"$sum": 1}}},
                             {"$sort":{"count": -1}},
                             {"$limit": 10}])))
```

    [{u'_id': u'yes', u'count': 6222},
     {u'_id': u'residential', u'count': 485},
     {u'_id': u'apartments', u'count': 305},
     {u'_id': u'office', u'count': 76},
     {u'_id': u'train_station', u'count': 58},
     {u'_id': u'house', u'count': 57},
     {u'_id': u'industrial', u'count': 53},
     {u'_id': u'concourse', u'count': 40},
     {u'_id': u'commercial', u'count': 17},
     {u'_id': u'roof', u'count': 9}]

> Lots of Residential buildings and appartments, nothing surprising as Mumbai is one of India's
most populated cities.

### _Top 10 Postcodes in the area_

```python
pprint(list(record.aggregate([{"$match": {'address.postcode': {"$exists": 1}}},
                         {"$group": {'_id': "$address.postcode", "count" : {"$sum": 1}}},
                             {"$sort":{"count": -1}},
                             {"$limit": 10}])))
```

    [{u'_id': u'400057', u'count': 135},
     {u'_id': u'400053', u'count': 63},
     {u'_id': u'400050', u'count': 56},
     {u'_id': u'400061', u'count': 30},
     {u'_id': u'400607', u'count': 29},
     {u'_id': u'400049', u'count': 12},
     {u'_id': u'400071', u'count': 8},
     {u'_id': u'400088', u'count': 8},
     {u'_id': u'400601', u'count': 7},
     {u'_id': u'400058', u'count': 7}]

# Conclusion and other ideas about the dataset

> When we audit the data, it is quite clear that although there are minor errors caused by human input, the dataset is fairly well-cleaned. Considering there are lots of contributors for this map, there are a great number of human errors in this project. I'd recommend a structured input form so everyone can input the same data format to reduce this error or we can create a more robust script to clean the data on a regular basis. 
<br/>
> The structured input will make the cleaning of data much easier. We can even specify data types and constraints on certain fields thus making comparison easier and maintaining the integrity of the data.
<br/>
> The above said solution is a bit difficult to implement. It would require a person to dedicate all of this time in writing scripts and designig the input struture, also users may find it difficult to submit data programatically because of such constraints. It might be a good idea to reward user's with more contributions in such senarios