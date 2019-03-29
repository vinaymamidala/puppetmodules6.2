class profile::base {

# Create sysadmin users & groups
#include users::sysadmin

# Base package installs

        package { "screen":
        ensure => "installed"
        }
        package { "nmap":
        ensure => "installed"
        }

        package { "bind-utils":
        ensure => "installed"
        }

        package { "telnet":
        ensure => "installed"
        }

        package { "wget":
        ensure => "installed"
        }

        package { "tree":
        ensure => "installed"
        }

        package { "vim-enhanced":
        ensure => "installed"
        }

        package { "mlocate":
        ensure => "installed"
        }

file{'/tmp/puppetagent_run_time.txt':
    ensure  =>  'present',
    content  =>  inline_template("Created by Puppet at <%= Time.now %>\n"),
  }
}
