#! /bin/bash

TRUNCATE_TABLE_RESULT=$($PSQL "TRUNCATE teams, games")
echo "TRUNCATED teams and games"

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
    if [[ $YEAR != year ]]
    then
        GET_WINNER=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
        if [[ -z $GET_WINNER ]]
        then
            INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
            WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
            echo "INSERTED $WINNER_ID, $WINNER INTO teams"
        fi

        GET_OPPONENT="$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")"
        if [[ -z $GET_OPPONENT ]]
        then
            INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
            OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
            echo "INSERTED $OPPONENT_ID, $OPPONENT INTO teams"
        fi

        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
        INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
        echo "INSERTED $YEAR, $ROUND, $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS INTO games"       
    fi
done
