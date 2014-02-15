# == Class remotesyslog::service
#
# This class is meant to be called from remotesyslog
# It ensures the service is running
#
class remotesyslog::service {

  service { 'remote_syslog':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
