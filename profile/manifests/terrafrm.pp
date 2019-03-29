class profile::terrafrm {

file { [ '/terraform']:
      ensure => 'directory',
     }

file {'vinay':
     path => '/terraform',
    ensure => 'file',
    mode => 'a+x',
    source => 'https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip',
   }

}
