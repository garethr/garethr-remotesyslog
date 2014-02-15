# == Class remotesyslog::install
#
class remotesyslog::install {
  include ruby

  ensure_packages['libssl-dev']

  package { 'remote_syslog':
    ensure   => present,
    provider => gem,
    require  => [
      Class['ruby'],
      Package['libssl-dev'],
    ],
  }

}
