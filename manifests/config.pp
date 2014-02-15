# == Class remotesyslog::config
#
# This class is called from remotesyslog
#
class remotesyslog::config {
  file { '/etc/init/remote_syslog.conf':
    source => 'puppet:///modules/remotesyslog/etc/init/remote_syslog.conf'
  }

  file { '/etc/init.d/remote_syslog':
    ensure => link,
    target => '/lib/init/upstart-job',
  }

  file { '/etc/log_files.yml':
    content => template('remotesyslog/etc/log_files.yml.erb')
  }
}
