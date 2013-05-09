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

  it 'sets up and configures graphite' do
    expect(chef_run).to include_recipe 'graphite::install'
    expect(chef_run).to include_recipe 'graphite::configure'
  end
end
