require 'chefspec'

describe 'graphite::logrotate' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path, :step_into => ['logrotate_app'])
  end

  let(:chef_run) do
    chef_runner.converge 'logrotate', 'graphite::logrotate'
  end
  
  it 'creates carbon-cache logrotate config' do
    chef_runner.node.set['graphite']['install_carbon'] = true
    chef_runner.node.set['graphite']['carbon']['enable_cache'] = true
    chef_run = chef_runner.converge 'logrotate', 'graphite::logrotate'
    expect(chef_run).to create_file_with_content '/etc/logrotate.d/carbon-cache', ''
  end
  
  it 'creates carbon-relay logrotate config' do
    chef_runner.node.set['graphite']['install_carbon'] = true
    chef_runner.node.set['graphite']['carbon']['enable_relay'] = true
    chef_run = chef_runner.converge 'logrotate', 'graphite::logrotate'
    expect(chef_run).to create_file_with_content '/etc/logrotate.d/carbon-relay', ''
  end
  
  it 'creates carbon-aggregator logrotate config' do
    chef_runner.node.set['graphite']['install_carbon'] = true
    chef_runner.node.set['graphite']['carbon']['enable_aggregator'] = true
    chef_run = chef_runner.converge 'logrotate', 'graphite::logrotate'
    expect(chef_run).to create_file_with_content '/etc/logrotate.d/carbon-aggregator', ''
  end
  
  it 'creates graphite webapp logrotate config' do
    chef_runner.node.set['graphite']['install_webapp'] = true
    chef_run = chef_runner.converge 'logrotate', 'graphite::logrotate'
    expect(chef_run).to create_file_with_content '/etc/logrotate.d/graphite', ''
  end
end
