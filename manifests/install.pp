# == Class remotesyslog::install
#
class remotesyslog::install {
  include ruby

  ensure_packages['libssl-dev', 'ruby-dev', 'build-essential']

  package { 'remote_syslog':
    ensure   => present,
    provider => gem,
    require  => [
      Class['ruby'],
      Package['libssl-dev'],
      Package['ruby-dev'],
      Package['build-essential'],
    ],
  }

}
