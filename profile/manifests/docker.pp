class profile::docker {


include 'docker'

docker::image { 'ubuntu':
   image_tag => 'trusty',
}
docker::run { 'helloworld':
  image   => 'ubuntu',
  command => '/bin/sh -c "while true; do echo hello world; sleep 1; done"',
}
}
