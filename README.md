# Mininet_Topology
NIP, AVP and KeyPair Forwarding Files\
Each directory contains shell scipt to run Experiemnt\
Instantiate mininet topology (e.g. ./KeyPair) \
Command on CLI : 
---------------------------------------------------------------------
1. sudo mn --custom 15_keypair.py --switch user --arp --topo=mytopo
---------------------------------------------------------------------
2. type xterm s1 h1 h2 on mininet command line.
---------------------------------------------------------------------
3. run source 15_keypair.sh on each xterm display
---------------------------------------------------------------------
4. "s1" xterm display , run command : \
  start (make sure each switch's key is installed),\
  then run "fail s1 200 (s1 link fail and run for 200 times)"
---------------------------------------------------------------------
5. "h1" xterm display , run command : 
  iperfc 200 (run 200 times)
---------------------------------------------------------------------
5. "h1" xterm display , run command : 
  iperfc 200 (run 200 times)
---------------------------------------------------------------------
6. "h2" xterm display , run command : 
  iperfs 200 (run 200 times)
---------------------------------------------------------------------
