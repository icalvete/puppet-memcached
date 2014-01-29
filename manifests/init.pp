class memcached () inherits memcached::params {

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
    subscribe => Class['memcached::config']
  }
  anchor {'memcached::end':
    require => Class['memcached::service']
  }
}
