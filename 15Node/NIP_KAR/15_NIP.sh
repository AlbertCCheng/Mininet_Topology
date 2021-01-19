#!/bin/bash
#set -x
# 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 
#73	79	83	89	97	101	103	107	109	113	127	131	137	139	149	151	157	163	167	173
#179 181	191	193	197	199	211	223	227	229	233	239	241	251	257	263	269	271	277	281
# 283	293	307	311	313	317	331	337	347	349	353	359	367	373	379	383	389	397	401	409
# 419	421	431	433	439	443	449	457	461	463	467	479	487	491	499	503	509	521	523	541
# 547	557	563	569	571	577	587	593	599	601	607	613	617	619	631	641	643	647	653	659
# 661	673	677	683	691	701	709	719	727	733	739	743	751	757	761	769	773	787	797	809
# 811	821	823	827	829	839	853	857	859	863	877	881	883	887	907	911	919	929	937	941
# 947	953	967	971	977	983	991	997	1009 1013 1019 1021	
declare -A matrix
# col[0]: portNum, col[1]:key1, col[2]:key2
matrix_col=3
switch_num=15

cur_port_Num=6654
arr_key1=(13 7 11 37 5 59 31 17 47 29 23 19 53 43 41)
#arr_key2=(23 29 31 37 41 97 43 53 101 103 107 109 113 127 131)

#key_mod="dpctl key-mod tcp:127.0.0.1:6654 5"
key_mod="dpctl key-mod tcp:127.0.0.1:"
key_mod2="dpctl key-mod2 tcp:127.0.0.1:"
#dump_key="dpctl dump-key tcp:127.0.0.1:6654"
dump_key="dpctl dump-key tcp:127.0.0.1:"
dump_key2="dpctl dump-key2 tcp:127.0.0.1:"

# dpctl mod-port tcp:127.0.0.1:6654 4 (up or down)
# dpctl mod-port tcp:127.0.0.1:6657 2 (up or down)

# KAR NIP and AVP test


function iperfs {

	x=100
	while [ $x -le 900 ]
		do	
			echo -e iperf server $x\m
			eval "iperf -s -u -p 5566 -i 0.01 -P $1 > NIP_$x"
			x=$(( $x + 100 ))
		done

}

function iperfc (){
	x=1
	while [ $x -le $(($1*9)) ]
		do	
			echo -e "\n--------------------------------------------------------------------------------------\n"
			echo -e "number $x iteration\n\n"

			eval "sed -i -e 's/$(( $x - 1 ))/$x/g' ./client.txt"
			count_fail=`cat ./failure.txt`
			count_c=`cat ./client.txt`
			
			while [ $count_c -ne $count_fail ]
				do	
					sleep .1
					count_fail=`cat ./failure.txt`
					count_c=`cat ./client.txt`
				done

			if [[ $x -lt $(($1+1)) ]] # $x < 31 $(($1+1))
			then
				echo -e "\n--------------------------------------------------------------------------------------\n"
				echo -e "iperf client 100m\n\n"
				sleep 1
				eval "iperf -c 10.0.0.2 -p 5566 -t 32 -u -b 100m"

			elif [[ $x -gt $(($1+0)) &&  $x -lt $(($1*2+1)) ]] # $x > 30 &&  $x < 61
			then
				echo -e "\n--------------------------------------------------------------------------------------\n"
				echo -e "iperf client 200m\n\n"
				sleep 1
				eval "iperf -c 10.0.0.2 -p 5566 -t 32 -u -b 200m"

			elif [[ $x -gt $(($1*2)) &&  $x -lt $(($1*3+1)) ]] # $x > 60 &&  $x < 91
			then
				echo -e "\n--------------------------------------------------------------------------------------\n"
				echo -e "iperf client 300m\n\n"
				sleep 1
				eval "iperf -c 10.0.0.2 -p 5566 -t 32 -u -b 300m"

			elif [[ $x -gt $(($1*3)) &&  $x -lt $(($1*4+1)) ]] # $x > 90 &&  $x < 121
			then
				echo -e "\n--------------------------------------------------------------------------------------\n"
				echo -e "iperf client 400m\n\n"
				sleep 1
				eval "iperf -c 10.0.0.2 -p 5566 -t 32 -u -b 400m"

			elif [[ $x -gt $(($1*4)) &&  $x -lt $(($1*5+1)) ]] # $x > 120 &&  $x < 151
			then
				echo -e "\n--------------------------------------------------------------------------------------\n"
				echo -e "iperf client 500m\n\n"
				sleep 1
				eval "iperf -c 10.0.0.2 -p 5566 -t 32 -u -b 500m"

			elif [[ $x -gt $(($1*5)) &&  $x -lt $(($1*6+1)) ]] # $x > 150 &&  $x < 181
			then
				echo -e "\n--------------------------------------------------------------------------------------\n"
				echo -e "iperf client 600m\n\n"
				sleep 1
				eval "iperf -c 10.0.0.2 -p 5566 -t 32 -u -b 600m"

			elif [[ $x -gt $(($1*6)) &&  $x -lt $(($1*7+1)) ]] # $x > 180 &&  $x < 211
			then

				echo -e "\n--------------------------------------------------------------------------------------\n"
				echo -e "iperf client 700m\n\n"
				sleep 1
				eval "iperf -c 10.0.0.2 -p 5566 -t 32 -u -b 700m"

			elif [[ $x -gt $(($1*7)) &&  $x -lt $(($1*8+1)) ]] # $x > 210 &&  $x < 241
			then

				echo -e "\n--------------------------------------------------------------------------------------\n"
				echo -e "iperf client 800m\n\n"
				sleep 1
				eval "iperf -c 10.0.0.2 -p 5566 -t 32 -u -b 800m"
			
			else							  # $x > 240
				echo -e "\n--------------------------------------------------------------------------------------\n"
				echo -e "iperf client 900m\n\n"
				sleep 1
				eval "iperf -c 10.0.0.2 -p 5566 -t 32 -u -b 900m"
			fi

			x=$(( $x + 1 ))
		done
	eval "sed -i -e 's/$(($1*9))/0/g' ./client.txt"
	eval "sed -i -e 's/$(($1*9))/0/g' ./failure.txt"
}

function fail (){
	x=1
		while [ $x -le $(($2*9)) ]
		do	
			echo -e "\n--------------------------------------------------------------------------------------\n"
			echo -e "number $x iteration\n\n"

			eval "sed -i -e 's/$(( $x - 1 ))/$x/g' ./failure.txt"
			count_fail=`cat ./failure.txt`
			count_c=`cat ./client.txt`

			while [ $count_fail -ne $count_c ]
				do
					sleep .1
					count_fail=`cat ./failure.txt`
					count_c=`cat ./client.txt`
				done
			sleep 1
			eval "breaklink $1"

			x=$(( $x + 1 ))
		done
}


function test_fail_switch (){
	x=1
		while [ $x -le $1 ]
		do	
			if [[ $x -lt 31 ]] # $x < 31
			then
				echo -e "\n--------------------------------------------------------------------------------------\n"
				echo -e "number $x iteration breaking s1 \n\n"
				eval "s1_fail"
				x=$(( $x + 1 ))
			elif [[ $x -gt 30 &&  $x -lt 61 ]] # $x > 30 &&  $x < 61
			then
				echo -e "\n--------------------------------------------------------------------------------------\n"
				echo -e "number $x iteration breaking s2 \n\n"
				eval "s2_fail"
				x=$(( $x + 1 ))
			else
				echo -e "\n--------------------------------------------------------------------------------------\n"
				echo -e "number $x iteration breaking s3 \n\n"
				eval "s3_fail"
				x=$(( $x + 1 ))
			fi
		done
}


function breaklink (){
		if [[ $1 == "s1" ]]
		then
			s1_fail
		elif [[ $1 == "s2" ]]
		then
			s2_fail
		else
			s3_fail
		fi
}

function s1_fail {

		echo -e "sleep 5 sec "
		sleep 5

		echo -e "\n---------------- S1 -> S2 Link Fail  ----------------------\n"
		# S1 -> S2
		eval "dpctl mod-port tcp:127.0.0.1:6654 2 down"
		eval "dpctl mod-port tcp:127.0.0.1:6655 1 down"

		sleep 20

		echo -e "\n---------------- S1 -> S2 Link up  ----------------------\n"
		# S1 -> S2
		eval "dpctl mod-port tcp:127.0.0.1:6654 2 up"
		eval "dpctl mod-port tcp:127.0.0.1:6655 1 up"

		sleep 5

		echo -e "\nsleep 5 sec over "

		sleep 3
}

function s2_fail {

		#sleep 6.991
		sleep 5
		echo -e "\n---------------- S2 -> S3 Link Fail  ----------------------\n"
		# S2 -> S3
		eval "dpctl mod-port tcp:127.0.0.1:6655 3 down"
		eval "dpctl mod-port tcp:127.0.0.1:6656 1 down"

		sleep 20

		echo -e "\n---------------- S2 -> S3 Link up  ----------------------\n"
		# S2 -> S3
		eval "dpctl mod-port tcp:127.0.0.1:6655 3 up"
		eval "dpctl mod-port tcp:127.0.0.1:6656 1 up"
		sleep 5
		#sleep 6.997
		echo -e "sleep 5 over "
		sleep 3
}

function s3_fail {

		#sleep 6.991
		sleep 5
		echo -e "\n---------------- S3 -> S5 Link Fail  ----------------------\n"
		# S3 -> S5
		eval "dpctl mod-port tcp:127.0.0.1:6656 3 down"
		eval "dpctl mod-port tcp:127.0.0.1:6658 1 down"

		sleep 20

		echo -e "\n---------------- S3 -> S5 Link up  ----------------------\n"
		# S3 -> S5
		eval "dpctl mod-port tcp:127.0.0.1:6656 3 up"
		eval "dpctl mod-port tcp:127.0.0.1:6658 1 up"
		sleep 5

		echo -e "sleep 5 over "
		sleep 3
	
}


function down {

		echo -e "\n---------------- S1 -> S2 Link down  ----------------------\n"
		# S1 -> S2
		eval "dpctl mod-port tcp:127.0.0.1:6654 2 down"
		eval "dpctl mod-port tcp:127.0.0.1:6655 1 down"

		echo -e "\n---------------- S2 -> S3 Link down  ----------------------\n"
		# S2 -> S3
		eval "dpctl mod-port tcp:127.0.0.1:6655 3 down"
		eval "dpctl mod-port tcp:127.0.0.1:6656 1 down"
		
		echo -e "\n---------------- S3 -> S5 Link down  ----------------------\n"
		# S3 -> S5
		eval "dpctl mod-port tcp:127.0.0.1:6656 3 down"
		eval "dpctl mod-port tcp:127.0.0.1:6658 1 down"
		
}

function up {

		echo -e "\n---------------- S1 -> S2 Link up  ----------------------\n"
		# S1 -> S2
		eval "dpctl mod-port tcp:127.0.0.1:6654 2 up"
		eval "dpctl mod-port tcp:127.0.0.1:6655 1 up"

		echo -e "\n---------------- S2 -> S3 Link up  ----------------------\n"
		# S2 -> S3
		eval "dpctl mod-port tcp:127.0.0.1:6655 3 up"
		eval "dpctl mod-port tcp:127.0.0.1:6656 1 up"
		
		echo -e "\n---------------- S3 -> S5 Link up  ----------------------\n"
		# S3 -> S5
		eval "dpctl mod-port tcp:127.0.0.1:6656 3 up"
		eval "dpctl mod-port tcp:127.0.0.1:6658 1 up"
}






# print value not understand yet
function init {
	for ((i = 0 ; i < switch_num ; i++)) do
		num=$(($cur_port_Num + $i))
		matrix[$i,0]=$num
		matrix[$i,1]="${arr_key1[$i]}"
		#matrix[$i,2]="${arr_key2[$i]}"
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
		#matrix[$i,2]=0
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
	#echo -e "wrt_key_2....."
	#key_mod2+="$1 "
	#key_mod2+="$3"
	#eval $key_mod2

	# resign value
	key_mod="dpctl key-mod tcp:127.0.0.1:"
	#key_mod2="dpctl key-mod2 tcp:127.0.0.1:"
}

# read_key 6654
function read_key() {
	echo -e "-----------------------------------------------------\nRead_key ....."
	dump_key+="$1"
	eval $dump_key
	echo -e "-----------------------------------------------------\n"
	
	# key_2
	#echo -e "-----------------------------------------------------\nRead_key2 ....."
	#dump_key2+="$1"
	#eval $dump_key2
	#echo -e "-----------------------------------------------------\n"
	# resign value
	dump_key="dpctl dump-key tcp:127.0.0.1:"
	#dump_key2="dpctl dump-key2 tcp:127.0.0.1:"
}

function start {
	init
}


