# == Class remotesyslog::config
#
# This class is called from remotesyslog
#
class remotesyslog::config {
  case $::operatingsystem {
    'Ubuntu': {
        file { '/etc/init/remote_syslog.conf':
            source => 'puppet:///modules/remotesyslog/etc/init/remote_syslog.conf'
        }

        file { '/etc/init.d/remote_syslog':
            ensure => link,
            target => '/lib/init/upstart-job',
        }
    }
    'Debian': {
        file{'/etc/init.d/remote_syslog':
            ensure => file,
            source => 'puppet://modules/remotesyslog/etc/init/remote_syslog.init.d',
        }
    }
    default: { fail("Operating System ${::operatingsystem} not supported by remotesyslog!") }
  }


  file { '/etc/log_files.yml':
    content => template('remotesyslog/etc/log_files.yml.erb')
  }
}
