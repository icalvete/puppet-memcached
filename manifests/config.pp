class memcached::config {

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      exec {'config_memory':
        command => "/bin/sed -i -e \"s/-m .*/-m ${memcached::params::memory}/\" ${memcached::params::config_file}",
        unless  => "/bin/grep '-m ${memcached::params::memory}' ${memcached::params::config_file}"
      }

      exec {'config_bind_address':
        command => "/bin/sed -i -e \"s/-l .*/-l ${memcached::params::bind_address}/\" ${memcached::params::config_file}",
        unless  => "/bin/grep '-m ${memcached::params::bind_address}' ${memcached::params::config_file}"
      }
    }
    /^(RedHat|CentOS)$/: {
      exec {'config_memory':
        command => "/bin/sed -i -e \"s/CACHESIZE=.*/CACHESIZE='${memcached::params::memory}'/\" ${memcached::params::config_file}",
        unless  => "/bin/grep '-m ${memcached::params::memory}' ${memcached::params::config_file}"
      }
    }
    default:{}
  }
}
