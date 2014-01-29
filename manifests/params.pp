class memcached::params {

  $memory       = '512'
  $bind_address = '0.0.0.0'

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      $package     = 'memcached'
      $config_file = '/etc/memcached.conf'
      $service     = 'memcached'
    }
    /^(RedHat|CentOS)$/: {
      $package     = 'memcached'
      $config_file = '/etc/sysconfig/memcached'
      $service     = 'memcached'
    }
    default: {
      fail ("${::operatingsystem} not supported.")
    }
  }
}
