#!/usr/bin/python

import sys
import pickle
sys.path.append("../tools/")

from feature_format import featureFormat, targetFeatureSplit
from tester import dump_classifier_and_data

### Task 1: Select what features you'll use.
### features_list is a list of strings, each of which is a feature name.
### The first feature must be "poi" which will be added to labels when we use target feature split.

features_list = ['poi']

### Load the dictionary containing the dataset
with open("final_project_dataset.pkl", "r") as data_file:
    data_dict = pickle.load(data_file)
    my_dataset = data_dict


# features not to be included in the dataset
unuseful_features = ['poi', 'email_address']

#adding all features to features_list except those considered unuseful
for key in my_dataset:
    for attribute in my_dataset[key]:
        if attribute not in unuseful_features:
            features_list.append(attribute)
    break

### Task 2: Remove outliers

data_dict.pop('TOTAL')
data_dict.pop('THE TRAVEL AGENCY IN THE PARK')
data_dict.pop('LOCKHART EUGENE E')

### Task 3: Create new feature(s)

for key in data_dict:
    try:
        data_dict[key]['fraction_to_poi'] = float(data_dict[key]['from_poi_to_this_person'])/data_dict[key]['to_messages']
    except:
        data_dict[key]['fraction_to_poi'] = "NaN"
    try:
        data_dict[key]['fraction_from_poi'] = float(data_dict[key]['from_this_person_to_poi'])/data_dict[key]['from_messages']
    except:
        data_dict[key]['fraction_from_poi'] = "NaN"

# add the features to features_list and remove the ones they replace

features_list.remove('from_messages')
features_list.remove('to_messages')
features_list.remove('from_poi_to_this_person')
features_list.remove('from_this_person_to_poi')
features_list.append('fraction_to_poi')
features_list.append('fraction_from_poi')

### Store to my_dataset for easy export below.
my_dataset = data_dict

### Extract features and labels from dataset for local testing
data = featureFormat(my_dataset, features_list, sort_keys = True)
labels, features = targetFeatureSplit(data)

#select the best features according to score

from sklearn.feature_selection import SelectKBest
selector = SelectKBest(k=12)
features = selector.fit_transform(features, labels)
feature_indices = selector.get_support(indices=True)

# update features_list accordingly

new_features_list = ['poi']
for index in feature_indices:
    new_features_list.append(features_list[index+1])

features_list = new_features_list

### Task 4: Try a varity of classifiers
### Please name your classifier clf for easy export below.
### Note that if you want to do PCA or other multi-stage operations,
### you'll need to use Pipelines. For more info:
### http://scikit-learn.org/stable/modules/pipeline.html
from sklearn.cross_validation import train_test_split
features_train, features_test, labels_train, labels_test = \
    train_test_split(features, labels, test_size=0.3, random_state=42)

# Decision Tree Classifier

from sklearn.tree import DecisionTreeClassifier
tree_clf = DecisionTreeClassifier(criterion = 'entropy', max_depth = 2 )
tree_clf.fit(features_train, labels_train)

#Naive Bayes Classifier

from sklearn.naive_bayes import GaussianNB
nb_clf = GaussianNB()
nb_clf.fit(features_train, labels_train)

# Random Forest Classifier

from sklearn.ensemble import RandomForestClassifier
rf_clf = RandomForestClassifier(max_depth = 10, n_estimators = 5)
rf_clf.fit(features_train, labels_train)

# Adaboost Classifier


from sklearn.ensemble import AdaBoostClassifier
ab_clf = AdaBoostClassifier(algorithm = 'SAMME', n_estimators = 5)
ab_clf.fit(features_train, labels_train)

# SVM Classifier using GridSearchCV
# Not used in final code as it wasn't much useful, commented because takes a lot of time to run

'''
from sklearn.grid_search import GridSearchCV
from sklearn.svm import SVC
parameters = {'kernel': ['rbf', 'linear'], 'C': [1, 10, 100, 1000]}
svm = SVC()
sv_clf = GridSearchCV(svm, parameters)
sv_clf.fit(features_train, labels_train)
sv_clf = sv_clf.best_estimator_

'''

### Task 5: Tune your classifier to achieve better than .3 precision and recall
### using our testing script. Check the tester.py script in the final project
### folder for details on the evaluation method, especially the test_classifier
### function. Because of the small size of the dataset, the script uses
### stratified shuffle split cross validation. For more info:
### http://scikit-learn.org/stable/modules/generated/sklearn.cross_validation.StratifiedShuffleSplit.html

#Evaluation

pred = tree_clf.predict(features_test)

from sklearn.metrics import precision_score
from sklearn.metrics import recall_score

print "Precision Score: ", precision_score(labels_test, pred)
print "Recall Score: ", recall_score(labels_test, pred)

#Select a classifier as final

clf = tree_clf


### Task 6: Dump your classifier, dataset, and features_list so anyone can
### check your results. You do not need to change anything below, but make sure
### that the version of poi_id.py that you submit can be run on its own and
### generates the necessary .pkl files for validating your results.
dump_classifier_and_data(clf, my_dataset, features_list)
