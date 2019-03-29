class profile::puppetmaster {

     ## firewall { '600 accept inbound puppet agent connections':
      ##          dport  => '8140',
       ##         proto  => 'tcp',
        ##        action => 'accept',
        ##}

        class { 'puppetdb::master::config':
              puppetdb_server => 'mygcp-puppetdb.us-east1-b.c.testing-applications-172193.internal',
                puppetdb_port   => 8081,
        }
        user { 'noc':
          ensure     => present,
          managehome => 'true',
          shell      => '/bin/bash',
          password   => '$6$UMCw6cxQGeduiBNS$0Hkk2U87fY2AZZp0LOqDlEncpCVeM2B.s/ePUyCbrCH3gGKGw0duPHVmuakL.vc7LCGmEiLwk9cBD5jetc9le0',
          groups     => 'wheel',
        }
}
