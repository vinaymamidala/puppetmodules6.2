class omd {

include omd::repos::redhat


package{'omd':
 ensure=>installed,
}


}

#$enhancers = [ 'omd' ]
#package { $enhancers: ensure => 'installed' }

