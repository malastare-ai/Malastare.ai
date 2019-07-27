# Malastare AI
# Data Science - *Solar power forecasting with cognitive toolkit in R*
# RIHAD VARIAWA, Data Scientist
# Renewable Solar Energy

## Overview

This repo reproduces [CNTK tutorial 106
B](https://github.com/Microsoft/CNTK/blob/master/Tutorials/CNTK_106B_LSTM_Timeseries_with_IOT_Data.ipynb)
- Deep Learning time series forecasting with Long Short-Term Memory
(LSTM) in R, by using the Keras R interface with Microsoft Cognitive
Toolkit in an Azure Data Science Virtual Machine (DSVM).

An Azure account can be created for free by visiting [Microsoft
Azure](https://azure.microsoft.com/free). This will then allow you to
deploy a [Ubuntu Data Science Virtual
Machine](https://docs.microsoft.com/en-us/azure/machine-learning/machine-learning-data-science-virtual-machine-overview)
through the [Azure Portal](https://ms.portal.azure.com). You can then
connect to the server's [Jupyter Notebook](http://jupyter.org/) instance
through a local web browser via ```https://<ip address>:8000```. Another 
alternative is to launch a remote desktop via X2Go (if it is a Linux DSVM), 
and then run the code in a Rstudio desktop version.
**NOTE**: there is an issue with OpenSSL certificate so remote access to an R session with RStudio Server does not work.

The repository contains three parts

- **Data** Solar panel readings collected from Internet-of-Things (IoTs)
    devices are used.
- **Code** R markdown file titled
    [SolarPanelForecastingCode](https://github.com/2series/Malastare/blob/master/SolarPanelForecasting/Code/SolarPanelForecastingCode.Rmd)
    wraps codes and step-by-step tutorials on build a LSTM model for
    forecasting from end to end. 
- **Docs** Blogs and decks will be added soon. 

## Business domain

The task presents a tutorial on forecasting solar panel power
readings by using a LSTM based neural network model trained on the
historical data. Solar power forecasting is a critical problem, and a
model with desirable estimation accuracy potentially benefiting many
domain-specific businesses such as energy trading, management, etc.

## Problem statement

The problem is to predict the maximum value of total power generation in
a day from the solar panel, by taking the sequential readings of solar
power generation at the current and past sampling moments.

## Data understanding

The dataset used in the task was collected from IoT devices
incorporated in solar panels. The data is available at the
[URL](https://guschmueds.blob.core.windows.net/datasets/solar.csv).

## Modeling

Model used in this task is based on LSTM, which is capable of
modeling long-term depenencies in time series data. By properly
processing the original data into sequences of power readings, a deep
neural network formed by LSTM cells and dropout layers can capture the
patterns in the time series so as to predict the output.

## Solution architecture

The experiment is conducted on a Ubuntu DSVM. 


Our 6 Step Problem Solving Roadmap


Gain the best results in solving complex and important problems. We-Do!

### Step 1: Identify the problem
At this stage, you are defining the scope of the problem you have to solve. Points to consider at this stage include: problem origin (if known), problem impact (e.g. on customers, on staff or reputation) and timeline to solve the problem.

Note: the time factor is important to consider because it influences how much time you can dedicate to thinking through the problem. In extreme conditions, you may run through this entire process in less than an hour.

### Step 2: Structure the problem
Putting the problem into a clear structure for analysis is one of the great insights we bring to our work. What does it mean to structure a problem? It means identifying the important issues.

### Step 3: Develop solutions
According to research by Chip and Dan Heath in their book “Decisive,” most managers develop only two solutions: “Do x or do not do X.” It will come as no surprise that this approach rarely delivers success. Binary choices tend to have a 50% or greater failure rate. On the other hand, fifty solutions is probably too many to handle especially if you are working through a problem solving process on your own.

The Solution Sweet Spot: developing three to five solutions is usually enough.

### Step 4: Select a solution to the problem
With a list of possible solutions on the table, it is now time to decide. 
Note: For large scale problem solving, you may have to follow an organizational template or policy if your solution requires a large amount of money.

### Step 5: Implement a solution
In this step, you put the solution into action. Implementation may become a project of its own. In that case, you have a full toolkit of project management tools and processes to call on.

Tip: If you are solving a novel problem, stay humble about your solution. It may not work or there may be a better way.

### Step 6: Monitor for success
Monitoring the solution and situation is a key step to ensure the problem is truly solved. Failing to follow up – especially if you have assigned the task to someone else – is a recipe for disaster. 

Monitoring is also important because problems are sometimes symptom of a deeper problem.

Tip: Increase the quantity and frequency of reporting when you are working through an important problem.
