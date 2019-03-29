class profile::puppetdb {

#include puppetdb

 firewall { '600 accept inbound puppetdb connections 8081':
                dport    => '8081',
                proto    => 'tcp',
                action   => 'accept',
        }

        firewall { '601 accept inbound puppetdb connections 8080':
                dport    => '8080',
                proto    => 'tcp',
                action   => 'accept',
        }

 firewall { '001 accept to omd server 6556':
              dport  => '6556',
              proto  =>  'tcp',
             action   => 'accept',

        }

# OMD Client Settings


#include omd::check_mk::agent
#omd::check_mk::addtag{'ngpxy':}
#include omd::check_mk::plugins::puppet

class { 'puppetdb':
               listen_address     => '0.0.0.0',
               disable_ssl        => false,
                ssl_set_cert_paths => true,
                ssl_deploy_certs   => true,
}
}                                                 
