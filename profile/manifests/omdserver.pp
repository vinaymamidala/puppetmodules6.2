class profile::omdserver{

#include my_fw

include omd

omd::site {'prod': }

omd::check_mk::import_resources{'prod':}

omd::check_mk::server::plugins::puppet { 'prod': }

omd::check_mk::addtag{'omdserver':}

include omd::check_mk::plugins::puppet

include omd::check_mk::agent

omd::site::user {'vmamidala': site=>'prod', privileges=>'admin', pass_md5=>'HVSJ.h631LfUw'}
omd::site::user {'xladmin': site=>'prod', privileges=>'admin', pass_md5=>'HVSJ.h631LfUw'}
omd::site::user {'noc': site=>'prod', privileges=>'admin', pass_md5=>'HVSJ.h631LfUw'}


#### Checks
omd::check_mk::var::set    {ignored_checktypes: site=>'prod', content=>'[ "ipmi_sensors", "if", "if64" ,"nfsmounts"]'}
omd::check_mk::var::set {inventory_df_exclude_fs: site=>'prod', content=>'["nfs", "fuse"]'}
omd::check_mk::var::set {'filesystem_default_levels#levels': site=>'prod', content=>'(80, 90)'}
omd::check_mk::var::set {'filesystem_default_levels#levels_low': site=>'prod', content=>'(60,75)'}
omd::check_mk::var::set {'filesystem_default_levels#magic': site=>'prod', content=>'0.5' }
omd::check_mk::var::set {'ntp_default_levels': site=>'prod', content=>'(10, 200.0, 1000.0)'}
#
omd::check_mk::var::append {ignored_checktypes: site=>'prod', content=>'["ipmi"]'}
#### Hostgroups
omd::check_mk::var::set    {define_hostgroups:     site=>'prod', content=>"'true'"}
omd::check_mk::var::set    {host_groups:     site=>'prod', content=>"[( 'omdserver', [ 'omdserver' ], ALL_HOSTS ),( 'docker', [ 'docker' ], ALL_HOSTS ),( 'elkserver', [ 'elkserver' ], ALL_HOSTS ),( 'spire_proxy', [ 'spire_proxy' ], ALL_HOSTS ),( 'ampuk', [ 'ampuk' ], ALL_HOSTS ),( 'http', [ 'http' ], ALL_HOSTS ),( 'https', [ 'https' ], ALL_HOSTS ),( 'ldap', [ 'ldap' ], ALL_HOSTS ),( 'puppetdb', [ 'puppetdb' ], ALL_HOSTS ),( 'Puppet', [ 'Puppet' ], ALL_HOSTS ),( 'ngpxy', [ 'ngpxy' ], ALL_HOSTS ),( 'git', [ 'git' ], ALL_HOSTS ),( 'rproxyadt', [ 'rproxyadt' ], ALL_HOSTS ),( 'rproxy', [ 'rproxy' ], ALL_HOSTS ),( 'oproxy', [ 'oproxy' ], ALL_HOSTS ),( 'fproxy', [ 'fproxy' ], ALL_HOSTS ),( 'rproxyimg', [ 'rproxyimg' ], ALL_HOSTS ),( 'level_ngproxy', [ 'level_ngproxy' ], ALL_HOSTS ),( 'rproxy_social_adt', [ 'rproxy_social_adt' ], ALL_HOSTS ),( 'ckproxy', [ 'ckproxy' ], ALL_HOSTS ),( 'rproxy-actions-aws-rmp', [ 'rproxy-actions-aws-rmp' ], ALL_HOSTS ), ( 'rproxy-actions-aws-edu', [ 'rproxy-actions-aws-edu' ], ALL_HOSTS ), ( 'rproxy-actions-aws-dev', [ 'rproxy-actions-aws-dev' ], ALL_HOSTS ), ( 'http_tcp_only', [ 'http_tcp_only' ], ALL_HOSTS ), ( 'https_tcp_only', [ 'https_tcp_only' ], ALL_HOSTS )]"}
#
##( 'docker', [ 'docker' ], ALL_HOSTS )
##
######
### http checks
### http tag and https tags indiivdually
### http checks for single usage http OR https
omd::check_mk::legacy::service {'http_tcp_80': site=>     'prod', command =>'check_tcp!80', mk_tags=>['http'], perfdata=>true}
omd::check_mk::legacy::service {'http_check': site=>     'prod', command =>'check_http!', mk_tags=>['http'], perfdata=>true}
omd::check_mk::legacy::service {'http_tcp_443': site=>     'prod', command =>'check_tcp!443', mk_tags=>['https'], perfdata=>true}
omd::check_mk::legacy::service {'https_check': site=>     'prod', command =>'check_http!-S -p 443', mk_tags=>['https'], perfdata=>true}
##
### httpz checks for dual http and https usage
omd::check_mk::legacy::service {'web_http_tcp_80': site=>     'prod', command =>'check_tcp!80', mk_tags=>['httpz'], perfdata=>true}
omd::check_mk::legacy::service {'web_http_tcp_443': site=>     'prod', command =>'check_tcp!443', mk_tags=>['httpz'], perfdata=>true}
omd::check_mk::legacy::service {'web_http_check': site=>     'prod', command =>'check_http!', mk_tags=>['httpz'], perfdata=>true}
omd::check_mk::legacy::service {'web_https_check': site=>     'prod', command =>'check_http!-S -p 443', mk_tags=>['httpz'], perfdata=>true}
##
#### rproxyimg custom http check
omd::check_mk::legacy::service {'rproxyimg_http_tcp_80': site=>     'prod', command =>'check_tcp!80', mk_tags=>['httprproxyimg'], perfdata=>true}
omd::check_mk::legacy::service {'rproxyimg_http_check': site=>     'prod', command =>'check_http! -u /dcs/status', mk_tags=>['httprproxyimg'], perfdata=>true}
##
#### ckprx*** custom http-tcp-only and https-tcp-only checks to just monitor whether 80 and 443 tcp ports are open
omd::check_mk::legacy::service {'http_tcp_only_80': site=>     'prod', command =>'check_tcp!80', mk_tags=>['http_tcp_only'], perfdata=>true}
omd::check_mk::legacy::service {'http_tcp_only_443': site=>     'prod', command =>'check_tcp!443', mk_tags=>['https_tcp_only'], perfdata=>true}
####
package { "perl-libwww-perl":
 ensure => "installed"
   }
}

