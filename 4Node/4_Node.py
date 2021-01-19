
from mininet.topo import Topo

class MyTopo( Topo ):
    "Simple topology example"

    def __init__( self ):
        "Create custom topo. "
        #Initialize topology
        Topo.__init__( self )

        s1 = self.addSwitch('s1', failmode='standalone', stp=True)
        s2 = self.addSwitch('s2', failmode='standalone', stp=True)
        s3 = self.addSwitch('s3', failmode='standalone', stp=True)
        s4 = self.addSwitch('s4', failmode='standalone', stp=True)
        """ current working
        h1 = self.addHost('h1', mac='40:0E:1A:00:00:00')
        h2 = self.addHost('h2', mac='C0:A5:2C:00:00:00')

        hex 
        h1 : 1A 0E 4
        h2 : 2C A5 C
        """

        h1 = self.addHost('h1', mac='40:0E:1A:00:00:00')
        h2 = self.addHost('h2', mac='C0:A5:2C:00:00:00')

        self.addLink(s1, h1, port1=1, port2=0)
        self.addLink(s4, h2, port1=4, port2=0)

        self.addLink(s1, s2, port1=2, port2=1)
        self.addLink(s1, s3, port1=3, port2=1)
        self.addLink(s1, s4, port1=4, port2=2)

        self.addLink(s2, s4, port1=2, port2=3)

        self.addLink(s3, s4, port1=2, port2=1)



topos = { 'mytopo': (lambda:MyTopo()) }


