class memcached::service {

  service{ 'memcached':
    enable     => true,
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
  }
}
