# Malastare AI
# Data Science - *Operationalizing heterogeneous DSVM set for elastic data science in the cloud.*
# RIHAD VARIAWA, Data Scientist
# Air Travel - Fight Delay

Received: 07 June 2019; Accepted: 17 July 2019; Published: 11 August 2019


Researchers are using artificial intelligence to help airlines price ancillary services such as checked bags and seat reservations in a way that is beneficial to customers' budget and privacy, as well as to the airline industry's bottom line.

When airlines began unbundling the costs of flights and ancillary services in 2008, many customers saw it as a tactic to quote a low base fare and then add extras to boost profits, the researchers said. In a new study, the researchers use unbundling to meet customer needs while also maximizing airline revenue with intelligent, individualized pricing models offered in real time as a customer shops.

The results of the study will be presented at the 2019 Conference on Knowledge Discovery and Data Mining on Aug. 6 in Anchorage, Alaska.

Airlines operate on very slim margins. While they earn a considerable portion of their revenue on ancillary purchases, unbundling can provide cost-saving opportunities to customers, as well. Customers don't have to pay for things they don't need, and discounts offered to customers who may otherwise pass on the extras can help convert a "no sale" into a purchase.

"Most airlines offer every customer the same price for a checked bag," said Lavanya Marla, a professor of industrial and enterprise systems engineering and study co-author. "However, not every customer has the same travel and budget needs. With AI, we can use information gathered while they shop to predict a price point at which they will be comfortable."

To hit that sweet spot, the pricing models use a combination of AI techniques -- machine learning and deep neural networks -- to track and assign a level of demand on an individual customer's flight preferences. The models consider various price factors such as flight origin, destination, the timing of travel and duration of a trip to assign a value on demand.

"For example, a customer who is traveling for a few days may not be motivated to pay for a checked bag," Marla said. "But, if you discount it to them at the right price -- where convenience outweighs cost -- you can complete that sales conversion. That is good for the customer and good for the airline."

In the study, the University of Illinois and Deepair Solutions team collaborated with a European airline over a period of approximately six months to gather data and test their models. While shopping, customers logged in to a pricing page where a predetermined percentage of customers are offered discounts on ancillary services.

"We started by offering the AI-modeled discounts to 5% of the customers who logged in," said Kartik Yellepeddi, a co-founder of Deepair Solutions and study co-author. "The airline then allowed us to adjust this percentage, as well as to experiment with various AI techniques used in our models, to obtain a robust dataset."

The airline began to see an uptick in ancillary sales conversions and revenue per customer, and allowed the researchers to offer discounts to all of the customers who logged in.

"Because of the unique nature of personalized pricing, we built a high level of equity and privacy into our models," Yellepeddi said. "There is a maximum price not to be exceeded, and we do not track customer demographics information like income, race, gender, etc., nor do we track a single customer during multiple visits to a sale site. Each repeat visit is viewed as a separate customer."

With an increase seen in ancillary sales conversions and ancillary revenue per offer -- up by 17% and 25%, respectively, according to the study -- the team said AI can help the airline industry move away from the concept of the "average customer" and tailor their offers to "individual travelers."

"In recent years, the airline industry has felt that it has been losing touch with its customer base," Marla said. "The industry is eager to find new ways to meet customer needs and to retain customer loyalty."

Deepair Solutions is an artificial intelligence company serving the travel industry. The company is headquartered in London and has an office in Dallas.


## Overview

This task presents an operationalization on hetergeneous DSVM set for elastic data science on Azure cloud for air delays

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

## Conflicts of Interest: The practitioner declare no conflict of interest.

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

