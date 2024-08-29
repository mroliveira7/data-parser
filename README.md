# TrueLogic Challenge: data parser

This application is a coding challenge proposed by TrueLogic. It implements two data parsers for two files that can be found in this repository in the folder `vendor`.
The proposed challenge follows these rules send by a recruiter:

> As discussed, you should perform the two following tasks using whatever programming language or tools you prefer, ideally by creating a small GitHub repo that can be shared with us. Also, you should not use any LLMs like ChatGPT to assist with their solution.
 - In the attached file (w_data.dat), you’ll find daily weather data. Download this text file, then write a program to output the day number (column one) with the smallest temperature spread (the maximum temperature is the second column, the minimum the third column).
 - The attached soccer.dat file contains the results from the English Premier League. The columns labeled ‘F’ and ‘A’ contain the total number of goals scored for and against each team in that season (so Arsenal scored 79 goals against opponents, and had 36 goals scored against them). Write a program to print the name of the team with the smallest difference in ‘for’ and ‘against’ goals.

At the end, the recruiter asked to use Ruby on Rails for this challenge.
I decided to implement a form where the user can upload each of the files mentioned above (located in `vendor/w_data.dat` and `vendor/soccer.dat`) and see the results. After the upload the user should see the response requested by the recruiter and a table containing the uploaded file for ground truth.

I opted to implement two parsers as service objects: `WeatherParser` and `SoccerParser` and another service object called `TrueLogicParser`. The `TrueLogicParser` should take care of calling the correct parser for each file. This is a good practice for future parsers to be implemented in the future. This way it's easy to add more parsers, organize business logic and avoids to make very bloated controllers and models 

### Dependencies
 - Ruby 3.1.0
 - Ruby on Rails 7.2.1
 - Sqlite 3

### Install

You should init this application as a common starter rails application:

 - Download the repository
 - cd into the download folder
 - Make sure to have the dependencies installed
 - Install libs with `bundle install`
 - Create database `rails db:create`
 - Run migrations `rails db:migrate`
 - Start rails server `rails s` or `rails s -d` for background server

### Testing the application

 - Go to `localhost:3000`
 - Add one of the files `vendor/w_data.dat` and `vendor/soccer.dat`
