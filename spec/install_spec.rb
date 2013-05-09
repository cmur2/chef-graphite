require 'chefspec'

describe 'graphite::install' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path, :step_into => ['python_pip'])
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

  it 'installs whisper via pip' do
    expect(chef_run).to install_package 'whisper'
  end
  
end
