class memcached::install {

  package{ $memcached::params::package:
    ensure  => present
  }
}

