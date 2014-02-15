# == Class: remotesyslog
#
# === Parameters
#
# [*logs*]
#   A list of files to watch for messages
#
# [*host*]
#   The remote syslog host to sent log events to
#
# [*cert*]
#   Path to ssl certificate used to secure remote syslog
#
# [*port*]
#   The port of the remote syslog server
#
class remotesyslog (
  $logs = $remotesyslog::params::logs,
  $host = $remotesyslog::params::host,
  $cert = $remotesyslog::params::cert,
  $port = undef,
) inherits remotesyslog::params {

  validate_array($logs)
  validate_re($::osfamily, '^Debian$', 'This module only supports Debian based systems')
  validate_string($port)

  unless $port {
    fail('You must provide a port')
  }

  class { 'remotesyslog::install': } ->
  class { 'remotesyslog::config': } ~>
  class { 'remotesyslog::service': } ->
  Class['remotesyslog']
}
