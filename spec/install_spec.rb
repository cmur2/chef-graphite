require 'chefspec'

describe 'graphite::install' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path)
  end

  let(:chef_run) do
    chef_runner.converge 'graphite::install'
  end

  it 'installs required native dependencies' do
    dep_pkgs = %w[python-cairo python-django python-django-tagging python-memcache python-pysqlite2 python-rrdtool python-simplejson python-twisted]
    dep_pkgs.each do |p|
      expect(chef_run).to install_package p
    end
  end

  it 'installs required pip dependencies' do
    dep_pip_pkgs = %w[whsiper txamqp]
    pending 'unable to detect pip installs'
  end

  [
    'both',
    'carbon',
    'graphite-web'
  ].each do |install_target|
    context "with install target #{install_target}" do
      it 'installs carbon via pip' do
        pending 'unable to detect pip installs' if install_target == 'both' or install_target == 'carbon'
      end

      it 'installs graphite-web via pip' do
        pending 'unable to detect pip installs' if install_target == 'both' or install_target == 'graphite-web'
      end
    end
  end

end
