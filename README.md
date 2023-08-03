# worldcup database

This is a required project for FCC certification

Instructions for building the project can be found at https://www.freecodecamp.org/learn/relational-database/build-a-world-cup-database-project/build-a-world-cup-database

## Overview

This project uses a Bash script to enter World Cup data from  the .csv file to the PostgreSQL database

Bash and PostgreSQL commands are then used to query the database for useful statistics

## What each file does:

1. `games.csv` contains data related to world cup games
2. `insert_data.sh` inserts the data from games.csv file to worldcup database
3. `queries.sh` queries the database for useful statistics
4. `output.txt` contains the the output of the queries