#!/bin/bash -x

echo "Welcome to Tic Tac Toe game."

declare -A board
#variables
row=3
column=3

function resettingBoard()
{
	for (( i=1; i<=$row; i++ ))
	do
		for (( j=1; j<=$column; j++ ))
		do
			board[$i,$j]="-"
		done
	done
}

resettingBoard

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

letterAssignment

function tossToPlayFirst()
{
	randomToss=$((RANDOM%2))
	if [[ $randomToss -eq 0 ]]
	then
		player1=$( letterAssignment )
	else
		player2=$( letterAssignment )
	fi
}

tossToPlayFirst

function playBoard()
{
	echo -e "$===========$"
	for (( i=1; i<=row; i++ ))
	do
		for (( j=1; j<=column+1; j++ ))
		do
			echo -e "| ${board[$i,$j]} \c"
		done
   echo -e "\n$===========$"		
	done
}

playBoard
