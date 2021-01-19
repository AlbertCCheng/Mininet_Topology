    
from mininet.topo import Topo

class MyTopo( Topo ):
    "Simple topology example"

    def __init__( self ):
        "Create custom topo. "
        #Initialize topology
        Topo.__init__( self )

       

        s1 = self.addSwitch('s1', listenPort=6654)
        s2 = self.addSwitch('s2', listenPort=6655)
        s3 = self.addSwitch('s3', listenPort=6656)
        s4 = self.addSwitch('s4', listenPort=6657)
        s5 = self.addSwitch('s5', listenPort=6658)
        s6 = self.addSwitch('s6', listenPort=6659)
        s7 = self.addSwitch('s7', listenPort=6660)
        s8 = self.addSwitch('s8', listenPort=6661)
        s9 = self.addSwitch('s9', listenPort=6662)
        s10 = self.addSwitch('s10', listenPort=6663)
        s11 = self.addSwitch('s11', listenPort=6664)
        s12 = self.addSwitch('s12', listenPort=6665)
        s13 = self.addSwitch('s13', listenPort=6666)
        s14 = self.addSwitch('s14', listenPort=6667)
        s15 = self.addSwitch('s15', listenPort=6668)


        h1 = self.addHost('h1', mac='10:03:03:C8:E1:0A', ip='10.0.0.1')
        h2 = self.addHost('h2', mac='B0:57:EB:10:B6:00', ip='10.0.0.2')
        

        self.addLink(s1, h1, port1=1, port2=0)
        self.addLink(s5, h2, port1=2, port2=0)

        #S1
        self.addLink(s1, s6, port1=5, port2=1)
        self.addLink(s1, s11, port1=4, port2=1)
        self.addLink(s1, s7, port1=3, port2=2)
        self.addLink(s1, s2, port1=2, port2=1)

        #S2
        self.addLink(s2, s7, port1=2, port2=1)
        self.addLink(s2, s3, port1=3, port2=1)

        #S3
        self.addLink(s3, s7, port1=2, port2=5)
        self.addLink(s3, s5, port1=3, port2=1)
        self.addLink(s3, s4, port1=4, port2=1)

        #S4
        self.addLink(s4, s5, port1=2, port2=3)

        #S5
        self.addLink(s5, s8, port1=4, port2=4)
        self.addLink(s5, s12, port1=5, port2=3)
        self.addLink(s5, s13, port1=6, port2=1)

        #S6
        self.addLink(s6, s10, port1=2, port2=1)

        #S7
        self.addLink(s7, s8, port1=4, port2=1)
        self.addLink(s7, s9, port1=3, port2=1)

        #S8
        self.addLink(s8, s9, port1=2, port2=4)
        self.addLink(s8, s12, port1=3, port2=4)

        #S9
        self.addLink(s9, s11, port1=2, port2=3)
        self.addLink(s9, s12, port1=3, port2=5)

        #S10
        self.addLink(s10, s11, port1=2, port2=2)
        self.addLink(s10, s14, port1=3, port2=1)

        #S11p1CA37C1870Bort1

        #S14
        self.addLink(s14, s15, port1=3, port2=1)
        
''''
        Original
            mac (hex):
            
            h1 : 1C A3 7C 18 70 B
                1968030451467
            
            h2 : 5D 7B EA C1 F9 9
                6424175058841

------------------------------------------------------------
        New
            h1 :  A E1 C8 03 03 1
                  747802472497


            h2 :  B6 10 EB 57 B
                  48872994171
'''

topos = { 'mytopo': (lambda:MyTopo()) }


