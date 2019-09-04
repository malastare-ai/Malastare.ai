# Malastare AI
# Data Science - *Spark based movie recommender*
# RIHAD VARIAWA, Data Scientist
# Movie Recommendation System

Received: 13 June 2019; Accepted: 13 July 2019; Published: 2 August 2019

## About recommender systems

Recommender systems have been there out for a while in the market. It uses two different types of algorithms to suggest the content to the users - content based and collaborative based

**Content-based** keeps track of the users watching habits and recommends them content similar to their interests

**Collaborative-based** recognizes users with similar tastes. It then suggests content based on their taste to each other and mostly continues to do so in the long run. For example, Netflix has a big recommender system which suggests users web-series or shows based on their watching habits or tastes. If a person binge-watched all five seasons of Breaking Bad, they will be immediately greeted with the “Better Call Saul” recommendation! Such is the power of recommender systems

## Project overview

The task is to illustrate how to efficiently build a movie recommendation system within 30 minutes!

The repo contains three parts

- **Data** Schemas and references to sample data used in the accelerator 
- **Code** Codes for training and scoring a movie recommender
- **Docs** Documents helping to build a recommender with Azure Machine Learning Service

## Business domain

Movie Recommendation (e-commerce, entertainment, retail, etc.)

## Data understanding

Typically data in a recommendation system has a schema of 
|user|item|rating|[timestamp]|
where user, item, and rating refer to user ID, item ID, and ratings given by a user towards an item

## Problem statement

Given historical observations of user preferences (i.e., ratings) on a set of items, how to predict and generate a set of items that the users will like most probably

## Modeling

A recommender is built by using Spark built-in collaborative filtering algorithm, which is a matrix factorization typed algorithm that is regularized by alternating least squares technique

## Solution architecture

The whole recommendation solution consists of Azure services such as Azure Data Science Virtual Machine, Azure blob storage, Azure Container Registry, Azure Container Services, etc. The building process is completed with Azure Machine Learning Service


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

