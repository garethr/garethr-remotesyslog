# == Class remotesyslog::params
#
# This class is meant to be called from remotesyslog
# It sets variables according to platform
#
class remotesyslog::params {
  $host = 'logs.papertrailapp.com'
  $cert = '/etc/syslog.papertrail.crt'
  $logs = []
}
