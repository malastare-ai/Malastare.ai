## Malastare AI
## RIHAD VARIAWA, Data Scientists
## Abalone Species


<p align="center">
  <img src="https://r-variawa.rstudio.cloud/f2988da6bff2415a937693aa688ebfca/file_show?path=%2Fcloud%2Fproject%2FMalastare-Artificial-Intelligence%2Fimage_gallery%2Flogo1.png" />
</p>


Received: 10 August 2019; Accepted: 06 February 2020; Published: 11 February 2020

### Overview
Two data analysis projects using **abalone data** to predict the Age of Abalone Species for harvesting. The first entails **exploratory data analysis.** The second involves **statistics** using ANOVA (analysis of variance) and (linear regression). Binary decision rules will be evaluated and a ROC (Receiver Operating Characteristic) curve developed. These projects require application of concepts and use of RStudio and R Markdown resulting in a .Rmd file and .html document.

<p align="center">
<img src=“./img/tasmanian_abalone.png" align="center" width="450px”/>
</p>


### Background
Abalones are an economic and recreational resource that is threatened by a variety of factors that includes: 

* pollution 
* disease
* loss of habitat 
* predation 
* commercial harvesting 
* sport fishing
* illegal harvesting

Environmental variation and the availability of nutrients affect the growth and maturation rate of abalones. Over the past two decades, it is estimated the commercial catch of abalone worldwide has declined in the neighborhood of 40%. Abalones are easily over harvested because of slow growth rates and variable reproductive success. Being able to quickly determine the Age composition of a regional abalone population would be an important capability for harvesting. The information so derived could be used to manage harvesting requirements.

### Supplemental information may be obtained from the following sources:

[Facts about Abalone](http://www.fishtech.com/facts.html)

[Abalone Introduction](http://www.marinebio.net/marinescience/06future/abintro.htm)

### Background information concerning the data
The data are derived from an observational study of abalones. **The intent of the investigators was to predict the Age of abalone from physical measurements thus avoiding the necessity of counting growth rings for Aging.** 

Ideally, a growth ring is produced each year of Aging. Currently, Age is determined by drilling the shell and counting the number of shell rings using a microscope. This is a difficult and time consuming process. Ring clarity can be an issue. At the completion of the breeding season sexing abalone can be difficult. Similar difficulties are experienced when trying to determine the sex of immature abalone.

The study was not successful. The researchers concluded additional information would be required such as weather patterns and location which affect food availability.

>Task 1 is an EDA (exploratory data analysis) to determine plausible reasons why the original study was unsuccessful in predicting abalone age based on physical characteristics. 

>Task 2 will involve development of a regression model; and, also address development of binary decision rules and a ROC (Receiver Operating Characteristic) curve.

### Dataset: abalones.csv
**Description:** This data file is derived from study of abalones in [Tasmania](https://en.wikipedia.org/wiki/Tasmania). There are 1036 observations and eight variables. The CLASS variable has been added for this analysis.

Note: When datasets are made available for public use, the original owners may obscure variable names or scale the data differently from original measurements. There are different reasons for this. This is not the case with these data and will be ignored for this analysis. Basic facts remain.

1. SEX = M (male), F (female), I (infant)
2. LENGTH = Longestshell length in cm
3. DIAM = Diameter perpendicular to length in cm
4. HEIGHT = Height perpendicular to length and diameter in cm
5. WHOLE = Whole weight of abalone in grams
6. SHUCK = Shucked weight of meat in grams
7. RINGS = Age (+1.5 gives the age in years)
8. CLASS = Age classification based on RINGS (A1= youngest,., A5=oldest)

### Data Analysis Project Task 1
(EDA) is a process of detective work which may lead to important insights. EDA by its nature tends to be visual. When starting to analyze data, a few good plots may save you hours of pouring over tables and summary statistics. This analysis will use important EDA methods to display aspects of these data such as: 

* The center or location of distributions 
* The variation in different variables 
* The shape of various distributions 
* The presence of outliers
* Differences in data characteristics between abalone classifications

Raw data are usually not perfect and that is the case here. This work may suggest hypotheses that need confirmatory testing, or it may identify difficulties with the data that need to be addressed in subsequent analyses or future studies of abalones. Task 2 will continue with the analysis and build upon what is found in Task 1.

### Data Analysis Project Task 2 
This analysis will involve development of a regression model; and, also address development of binary decision rules and a Receiver Operating Characteristic (ROC) curve for harvesting abalone. 

Using our mydata file from the first task for this analysis. Results from the first task will be referenced as needed.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project, you agree to abide by its terms.

The project material is licensed [CC-BY-SA](https://creativecommons.org/licenses/by-sa/4.0/), meaning you are free to use it, change it, and remix it as long as you give appropriate credit and distribute any new materials under the same license.  The _code_ is [MIT](https://opensource.org/licenses/MIT)-licensed.

## Conflicts of Interest: The practitioner declare no conflict of interest.
