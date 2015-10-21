class memcached (

$port            = $memcached::params::port,
$memory          = $memcached::params::memory,
$max_object_size = $memcached::params::max_object_size

) inherits memcached::params {

  anchor {'memcached::begin':
    before => Class['memcached::install']
  }
  class {'memcached::install':
    require => Anchor['memcached::begin']
  }
  class {'memcached::config':
    require => Class['memcached::install']
  }
  class {'memcached::service':
    require => Class['memcached::config']
  }
  anchor {'memcached::end':
    require => Class['memcached::service']
  }
}
