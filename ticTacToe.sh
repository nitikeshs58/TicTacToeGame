#!/bin/bash -x

echo "Welcome to Tic Tac Toe game."

declare -A board
#constants
ROW=3
COLUMN=3
count=1

function resettingBoard()
{
	for (( i=1; i<=$ROW; i++ ))
	do
		for (( j=1; j<=$COLUMN; j++ ))
		do
			board[$i,$j]="-"
		done
	done
}

function letterAssignment()
{
	randomLetter=$((RANDOM%2))
	if [[ $randomLetter -eq 0 ]]
	then
		player="O"
	else
		player="X"
	fi
	echo $player
}

function tossToPlayFirst()
{
	randomToss=$((RANDOM%2))
	if [[ $randomToss -eq 0 ]]
	then
		currentPlayer=$( letterAssignment $(()) )
	else
		currentPlayer=$( letterAssignment $(()) )
	fi
}

function playBoard()
{
	echo -e "$===========$"
	for (( i=1; i<=ROW; i++ ))
	do
		for (( j=1; j<=COLUMN+1; j++ ))
		do
			echo -e "| ${board[$i,$j]} \c"
		done
	echo -e "\n$===========$"
	done
}

function changePlayer()
{
	if [[ $1 == "X" ]]
	then
		currentPlayer="O"
	else
		currentPlayer="X"
	fi
}

function checkWin()
{
	match3=0
	match4=0
	win=0
	for (( i=1; i<=3; i++ ))
	do
		match1=0
		match2=0
		#row check
		for (( j=1; j<=3; j++ ))
		do
			if [[ ${board[$i,$j]} == $1 ]]
			then
				match1=$((match1+1))
			fi
		done

		#column check
		for (( k=1; k<=3; k++ ))
		do
			if [[ ${board[$k,$i]} == $1 ]]
			then
				match2=$((match2+1))
			fi
		done

		#diagonalOne
		if [[ ${board[$i,$i]} == $1 ]]
		then
			match3=$((match3+1))
		fi

		#diagonalTwo
		for (( y=1; y<=3; y++ ))
		do
			add=$((i+y))
			if [[ $add == 4 && ${board[$i,$y]} == $1 ]]
			then
				match4=$((match4+1))
			fi
		done

	if [[ $match1 == 3 || $match2 == 3 || $match3 == 3 || $match4 == 3 ]]
	then
		win=1
	fi
	done
	count=$((count+1))
}

function playingGame()
{
	row1=$1
	column1=$2
	if [[ ${board[$row1,$column1]} == "-" ]]
	then
		board[$row1,$column1]=$currentPlayer
		playBoard
		checkWin $currentPlayer
		if [[ $win == 1 ]]
		then
			echo "$currentPlayer wins"
			exit
		fi
			changePlayer $currentPlayer
	else
		echo "No Space available"
	fi
}
#checkwin before playing game
function computerPlayToWin()
{
	for (( m=1; m<=ROW; m++ ))
	do
		for (( n=1; n<=COLUMN; n++ ))
		do
			if [[ ${borad[$m,$n]} == "-" ]]
			then
				board[$m,$n]=$currentPlayer
				checkWin $currentPlayer
				if [[ $win == 0 ]]
				then
					board[$m,$n]="-"
				fi
			fi
		done
	done
}

resettingBoard
tossToPlayFirst
playBoard

while [[ $count -le 9 ]]
do
	if [[ $currentPlayer == "X" ]]
	then
		read -p "Enter row Position: " rowPosition
		read -p "Enter column position: " columnPosition
		playingGame $rowPosition $columnPosition
	else
		echo -e "\nComputer turn :\n"
		computerPlayToWin
		rowPosition=$((RANDOM%3+1))
		columnPosition=$((RANDOM%3+1))
		playingGame $rowPosition $columnPosition
	fi
done

if [[ $win == 0 ]]
then
	echo "Game Tie"
fi
