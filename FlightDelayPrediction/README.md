# Malastare AI
# Data Science - *Operationalizing heterogeneous DSVM set for elastic data science in the cloud.*
# RIHAD VARIAWA, Data Scientist
# Air Travel

## Overview

This task presents an operationalization on hetergeneous DSVM set for elastic data science on Azure cloud 

The repository contains three parts

- **Data** Sample of air delay data is used
- **Code** An R markdown where step-by-step guide-line is provided as tutorial. Code scripts that will be executed remotely on DSVMs are placed under the sub-directories 
- **Docs** Blog and presentation decks about this work will be added soon

## Business domain

The task presents a walk-through on how to operationalize an end-to-end predictive analysis on air delay data with a heterogeneous set of Azure DSVMs. Modelling and feature engineering for this part are merely for illustration purpose, meaning that there is no fine-tune performed to achieve an optimal performance

## Data understanding

The dataset used in this task is a sub set (10%) of the well-known air delay data set. The original dataset can be obtained [here](https://packages.revolutionanalytics.com/datasets/)

## Problem statement

The problem is to predict air delays in air-travel given features such as *day of month*, *day of week*, *origin of flight*, etc

## Modeling

For illustration purpose, a deep learning neural network is trained with and without GPU acceleration, *merely to compare the difference in training time*. While the focus is not primarily on model performance, readers can easily fine tune parameters or adjust network topology on their own

## Solution architecture

The overall architecture is depicted as follows
![Diagram of elastic use of DSVM for an air delay prediction project. DSVMs with different sizes and features are deployed to meet the requirements from each sub-tasks in the project.](Docs/misc/architecture.png)

A heterogeneous set of DSVMs for different tasks in a data science project, i.e., experimentation with a standalone-mode Spark, GPU-accelerated deep neural network training, and model deployment via web services, respectively. The benefits of doing this is that each provisioned DSVM will suit the specific task of each project sub-task, and stay alive only when it is needed

Detailed information for each of the machines is listed as follows

|DSVM name|DSVM Size|OS|Description|Price|
|---------|--------------------|--------|-----------------------|--------|
|spark|Standard F16 - 16 cores and 32 GB memory|Linux|Standalone mode Spark for data preprocessing and feature engineering.|$0.796/hr|
|deeplearning|Standard NC6 - 6 cores, 56 GB memory, and Tesla K80 GPU|Windows|Train deep neural network model with GPU acceleration.|$0.9/hr|
|webserver|Standard D4 v2 - 8 cores and 28 GB memory|Linux|Deployed as a server where MRS service is published and run on.|$0.585/hr|

Data storage is used for temporarily preserving processed data, and it can also be seamlessly connected to DSVMs and administrated within R session by using AzureSMR package  


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

