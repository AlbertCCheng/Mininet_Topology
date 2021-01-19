#!/bin/bash
#set -x
# 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 
# 101 103 107 109 113 127 131 137 137 149 151 157 163 167 173

declare -A matrix
# col[0]: portNum, col[1]:key1, col[2]:key2
matrix_col=3
switch_num=4

cur_port_Num=6654
arr_key1=(5 11 17 29)
arr_key2=(7 31 19 23)

#key_mod="dpctl key-mod tcp:127.0.0.1:6654 5"
key_mod="dpctl key-mod tcp:127.0.0.1:"
key_mod2="dpctl key-mod2 tcp:127.0.0.1:"
#dump_key="dpctl dump-key tcp:127.0.0.1:6654"
dump_key="dpctl dump-key tcp:127.0.0.1:"
dump_key2="dpctl dump-key2 tcp:127.0.0.1:"

# dpctl mod-port tcp:127.0.0.1:6654 4 (up or down)
# dpctl mod-port tcp:127.0.0.1:6657 2 (up or down)

function a {

		eval "dpctl mod-port tcp:127.0.0.1:6657 2 down"

}

function b {

		eval "dpctl mod-port tcp:127.0.0.1:6657 2 up"

}

function c {
		x=1
		while [ $x -le 10 ]
		do	
			eval "dpctl dump-ports tcp:127.0.0.1:6654 4"
			x=$(( $x + 1 ))
		done

}



function dump {
		while :
		do	
			eval "dpctl dump-key tcp:127.0.0.1:6654"
			eval "dpctl dump-key2 tcp:127.0.0.1:6654"
		done

		#x=1
		#while [ $x -le 20 ]
		#do
		#	eval "dpctl dump-key tcp:127.0.0.1:6654"
		#	eval "dpctl dump-key2 tcp:127.0.0.1:6654"
		#	x=$(( $x + 1 ))
		#done
}



function down {
		echo -e "\n----------------------  Link Fail  ----------------------\n"
		#eval "dpctl mod-port tcp:127.0.0.1:6654 5 down"

		eval "dpctl mod-port tcp:127.0.0.1:6654 4 down"
		eval "dpctl mod-port tcp:127.0.0.1:6657 2 down"
		sleep 10
		eval "dpctl mod-port tcp:127.0.0.1:6654 4 up"
		eval "dpctl mod-port tcp:127.0.0.1:6657 2 up"
}

function up {
		echo -e "\n----------------------  Link Recovery  ----------------------\n"
		#eval "dpctl mod-port tcp:127.0.0.1:6654 5 up"

		eval "dpctl mod-port tcp:127.0.0.1:6654 4 up"
		eval "dpctl mod-port tcp:127.0.0.1:6657 2 up"
}

# print value not understand yet
function init {
	for ((i = 0 ; i < switch_num ; i++)) do
		num=$(($cur_port_Num + $i))
		matrix[$i,0]=$num
		matrix[$i,1]="${arr_key1[$i]}"
		matrix[$i,2]="${arr_key2[$i]}"
	done

	f1="%$((${#switch_num}+1))s"
	f2=" %9s"

	printf "$f1" ''
	for ((i=0;i<switch_num;i++)) do
		printf "$f2" $i
	done
	echo

	for ((j = 0; j < matrix_col ; j++)) do
		printf "$f1" $j
		for ((i = 0; i < switch_num; i++)) do
			printf "$f2" ${matrix[$i,$j]}
		done
		echo
	done

	iterate
}

# Reset all Key to 0 to enable openflow Switch (not used yet)
function reset {

	echo -e "\n\n\n----------------------  RESET  ----------------------\n"
	echo -e "----------------------  RESET  ----------------------\n"
	echo -e "----------------------  RESET  ----------------------\n"
	for ((i = 0 ; i < switch_num ; i++)) do
		num=$(($cur_port_Num + $i))
		matrix[$i,0]=$num
		matrix[$i,1]=0
		matrix[$i,2]=0
	done


	f1="%$((${#switch_num}+1))s"
	f2=" %9s"

	printf "$f1" ''
	for ((i=0;i<switch_num;i++)) do
		printf "$f2" $i
	done
	echo

	for ((j = 0; j < matrix_col ; j++)) do
		printf "$f1" $j
		for ((i = 0; i < switch_num; i++)) do
			printf "$f2" ${matrix[$i,$j]}
		done
		echo
	done

	iterate
} 


function iterate {
	for ((i = 0 ; i < switch_num ; i++)) do
		argv0="${matrix[$i,0]}"
		argv1="${matrix[$i,1]}"
		argv2="${matrix[$i,2]}"
		curSwitch=1
		curSwitch=$(($curSwitch + $i))
		echo -e "\n\nS$curSwitch\n-----------------------------------------------------\nargv0: $argv0, argv1: $argv1, argv2: $argv2\n-----------------------------------------------------"
		# Write key
		wrt_key $argv0 $argv1 $argv2
		# Read key
		read_key $argv0
	done
}

# wrt_key 6654 5 7
function wrt_key() {
	echo -e "wrt_key....."
	key_mod+="$1 "
	key_mod+="$2"
	eval $key_mod

	# key_2
	echo -e "wrt_key_2....."
	key_mod2+="$1 "
	key_mod2+="$3"
	eval $key_mod2

	# resign value
	key_mod="dpctl key-mod tcp:127.0.0.1:"
	key_mod2="dpctl key-mod2 tcp:127.0.0.1:"
}

# read_key 6654
function read_key() {
	echo -e "-----------------------------------------------------\nRead_key ....."
	dump_key+="$1"
	eval $dump_key

	# key_2
	echo -e "-----------------------------------------------------\nRead_key2 ....."
	dump_key2+="$1"
	eval $dump_key2
	echo -e "-----------------------------------------------------\n"
	# resign value
	dump_key="dpctl dump-key tcp:127.0.0.1:"
	dump_key2="dpctl dump-key2 tcp:127.0.0.1:"
}

function start {
	init
}

#echo -e "$key_mod\n$key_mod2\n$dump_key\n$dump_key2"
#key_mod="dpctl key-mod tcp:127.0.0.1:"
#key_mod2="dpctl key-mod2 tcp:127.0.0.1:"
#dump_key="dpctl dump-key tcp:127.0.0.1:"
#dump_key2="dpctl dump-key2 tcp:127.0.0.1:"
#echo -e "$key_mod\n$key_mod2\n$dump_key\n$dump_key2"


