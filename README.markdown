
[Remote Syslog](https://github.com/papertrail/remote_syslog) is a handy
tool from Papertrail which can collect lines from a series of log files
and send them off to a remote syslog server.

This module is also available on the [Puppet Forge](https://forge.puppetlabs.com/garethr/remotesyslog).

[![Build Status](https://secure.travis-ci.org/garethr/garethr-remotesyslog.png)](http://travis-ci.org/garethr/garethr-remotesyslog)

## Usage

```puppet
class { 'remotesyslog':
  logs => [
    '/var/log/1.log,
    '/var/log/2.log,
  ]
  port => 12345,
}
```

## Alternatives and inspiration

A few Papertrail modules already exist, for example from
[davidwinter](https://github.com/davidwinter/puppet-papertrail) and from
[bdossantos](https://github.com/bdossantos/puppet-module-papertrail) but
both of them want to own your entire syslog configuration as well. This
module only installs and manages remote_syslog.
