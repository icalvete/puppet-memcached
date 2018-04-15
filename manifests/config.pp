class memcached::config {

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      exec {'config_port':
        command => "/bin/sed -i -e \"s/-p .*/-p ${memcached::port}/\" ${memcached::params::config_file}",
        unless  => "/bin/grep '-m ${memcached::port}' ${memcached::params::config_file}"
      }

      exec {'config_memory':
        command => "/bin/sed -i -e \"s/-m .*/-m ${memcached::memory}/\" ${memcached::params::config_file}",
        unless  => "/bin/grep '-m ${memcached::memory}' ${memcached::params::config_file}"
      }

      exec {'config_bind_address':
        command => "/bin/sed -i -e \"s/-l .*/-l ${memcached::params::bind_address}/\" ${memcached::params::config_file}",
        unless  => "/bin/grep '-l ${memcached::params::bind_address}' ${memcached::params::config_file}"
      }

      exec {'pre_config_max_object_size':
        command => "/bin/echo '-I MAXOBJECTSIZE' >> ${memcached::params::config_file}",
        unless  => "/bin/grep '\-I' ${memcached::params::config_file}"
      }

      exec {'config_max_object_size':
        command => "/bin/sed -i -e \"s/-I .*/-I ${memcached::max_object_size}/\" ${memcached::params::config_file}",
        unless  => "/bin/grep '-I ${memcached::max_object_size}' ${memcached::params::config_file}",
        require => Exec['pre_config_max_object_size']
      }
    }
    /^(RedHat|CentOS)$/: {
      exec {'config_memory':
        command => "/bin/sed -i -e \"s/CACHESIZE=.*/CACHESIZE='${memcached::memory}'/\" ${memcached::params::config_file}",
        unless  => "/bin/grep '-m ${memcached::memory}' ${memcached::params::config_file}"
      }
      exec {'config_max_object_size':
        command => "/bin/sed -i -e \"s/OPTIONS=.*/OPTIONS='-I ${memcached::max_object_size}'/\" ${memcached::params::config_file}",
        unless  => "/bin/grep '-m ${memcached::max_object_size}' ${memcached::params::config_file}"
      }
    }
    default:{}
  }

  exec {'disable_udp':
    command => "/bin/echo '-U 0' >> ${memcached::params::config_file}",
    unless  => "/bin/grep '\-U 0' ${memcached::params::config_file}"
  }
}
