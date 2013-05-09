require 'chefspec'

describe 'graphite::default' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path)
  end

  let(:chef_run) do
    chef_runner.converge 'graphite::default'
  end
  
  it 'requires python and pip' do
    expect(chef_run).to include_recipe 'python'
  end

  it 'creates graphite user and group' do
    expect(chef_run).to create_user 'graphite'
    expect(chef_run).to create_group 'graphite'
  end

  it 'rspects custom graphite user and group names' do
    chef_runner.node.set['graphite']['user'] = 'foo'
    chef_runner.node.set['graphite']['group'] = 'bar'
    chef_run = chef_runner.converge 'graphite::default'
    expect(chef_run).to create_user 'foo'
    expect(chef_run).to create_group 'bar'
  end

  it 'creates runfiles directory' do
    expect(chef_run).to create_directory '/var/run/graphite'
  end

  it 'sets up and configures graphite' do
    expect(chef_run).to include_recipe 'graphite::install'
    expect(chef_run).to include_recipe 'graphite::configure'
  end
end
