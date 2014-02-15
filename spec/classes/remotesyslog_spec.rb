require 'spec_helper'

describe 'remotesyslog' do
  context 'supported operating systems' do
    let(:facts) {{ :osfamily => 'Debian' }}
    describe "remotesyslog class without any parameters on Debian" do
      let(:params) {{ :port => 12345 }}
      it { should compile.with_all_deps }

      it { should contain_class('remotesyslog::params') }
      it { should contain_class('remotesyslog::install').that_comes_before('remotesyslog::config') }
      it { should contain_class('remotesyslog::config') }
      it { should contain_class('remotesyslog::service').that_subscribes_to('remotesyslog::config') }

      it { should contain_service('remote_syslog') }
      it { should contain_package('remote_syslog').with_provider('gem') }

      it { should contain_class('ruby') }
      it { should contain_package('libssl-dev') }

      it { should contain_file('/etc/init/remote_syslog.conf') }
      it { should contain_file('/etc/init.d/remote_syslog').with_ensure('link') }
      it { should contain_file('/etc/log_files.yml').with_content(/logs\.papertrailapp\.com/) }
    end

    describe "passing a custom host" do
      let(:params) {{ :host => 'logs.example.com', :port => 12345 }}
      it { should contain_file('/etc/log_files.yml').with_content(/logs\.example\.com/) }
    end

    describe "not passing a custom port" do
      it { expect { should contain_package('remotesyslog') }.to raise_error(Puppet::Error, /You must provide a port/) }
    end

    describe "passing a custom port" do
      let(:params) {{ :port => 12345 }}
      it { should contain_file('/etc/log_files.yml').with_content(/port: 12345/) }
    end

    describe "passing log files to monitor" do
      let(:params) {{ :logs => ['/var/log/1.log', '/var/log/2.log'], :port => 12345 }}
      it { should contain_file('/etc/log_files.yml').with_content(/var\/log\/1\.log/) }
    end

    describe "passing invalid log files to monitor" do
      let(:params) {{ :logs => 'not an array'}}
      it { expect { should contain_package('remotesyslog') }.to raise_error(Puppet::Error) }
    end
  end

  context 'unsupported operating system' do
    describe 'remotesyslog class without any parameters on RedHat' do
      let(:facts) {{ :osfamily => 'RedHat'}}

      it { expect { should contain_package('remotesyslog') }.to raise_error(Puppet::Error) }
    end
  end
end
