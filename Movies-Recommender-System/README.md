![](https://media.giphy.com/media/ysoK6qc1xpNxm/giphy.gif)


A Movies Recommender System built with Python. 

Using the IMDB 5000 movie dataset.

Link to dataset :- https://www.kaggle.com/carolzhangdc/imdb-5000-movie-dataset

Link to the web application :- https://recommendor-system.herokuapp.com/

A blog regarding the application can be read on https://2series.github.io/post/moviesrecommender/

I used Flask web framework in built in Python to put in on web.

### Why Flask?
* Easy to use.
* Built in development server and debugger.
* Integrated unit testing support.
* RESTful request dispatching.
* Extensively documented.

### Project Structure
This project has four major parts :

create.py - This contains two files for future use--data.csv and numpy matrix
main.py - This contains Flask APIs that receives movies details through GUI or API calls, and runs the application
templates - This folder contains the HTML template

### Running The Project
1. Ensure that you are in the project home directory. Create the machine learning model by running below command -
```
python model.py
```
This would create a serialized version of our model into a file model.pkl

2. Run main.py using below command to start Flask API
```
python main.py
```
By default, flask will run on port 5000.
