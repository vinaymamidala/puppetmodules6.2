class terraform::init {

file {'terraform package':
     path => 'home/myuser',
    ensure => 'file',
     mode => 'a+x',
    source => 'https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip',
   }
   
}
