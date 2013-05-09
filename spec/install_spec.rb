require 'chefspec'

describe 'graphite::install' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path)
  end

  let(:chef_run) do
    chef_runner.converge 'graphite::install'
  end

  {
    'Debian 6' =>  {
      'platform' => 'debian',
      'version' => '6.0.0',
      'dep_pkgs' => %w[python-cairo python-django python-django-tagging python-flup python-memcache python-pysqlite2 python-rrdtool python-simplejson python-twisted]
    }
  }.each do |display_name, config|
    context "on #{display_name}" do
      it 'installs required native dependencies' do
        chef_runner.node.automatic_attrs['platform'] = config['platform']
        chef_runner.node.automatic_attrs['platform_version'] = config['version']
        chef_run = chef_runner.converge 'graphite::install'
        config['dep_pkgs'].each do |p|
          expect(chef_run).to install_package p
        end
      end
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
  ].each do |install_mode|
    context "with install target #{install_mode}" do
      it 'installs carbon via pip' do
        chef_runner.node.set['graphite']['install_mode'] = install_mode
        chef_run = chef_runner.converge 'graphite::install'
        
        pending 'unable to detect pip installs' if install_mode == 'both' or install_mode == 'carbon'
      end

      it 'installs graphite-web via pip' do
        chef_runner.node.set['graphite']['install_mode'] = install_mode
        chef_run = chef_runner.converge 'graphite::install'

        pending 'unable to detect pip installs' if install_mode == 'both' or install_mode == 'graphite-web'
      end
    end
  end

end
