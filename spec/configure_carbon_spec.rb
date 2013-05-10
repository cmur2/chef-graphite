require 'chefspec'

describe 'graphite::configure_carbon' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path)
  end

  let(:chef_run) do
    chef_runner.converge 'graphite::configure_carbon'
  end
  
  it 'creates an carbon-cache init script' do
    chef_runner.node.set['graphite']['carbon']['enable_cache'] = true
    chef_run = chef_runner.converge 'graphite::configure_carbon'
    expect(chef_run).to create_file_with_content '/etc/init.d/carbon-cache', ''
  end

  it 'creates an carbon-relay init script' do
    chef_runner.node.set['graphite']['carbon']['enable_relay'] = true
    chef_run = chef_runner.converge 'graphite::configure_carbon'
    expect(chef_run).to create_file_with_content '/etc/init.d/carbon-relay', ''
  end

  it 'creates an carbon-aggregator init script' do
    chef_runner.node.set['graphite']['carbon']['enable_aggregator'] = true
    chef_run = chef_runner.converge 'graphite::configure_carbon'
    expect(chef_run).to create_file_with_content '/etc/init.d/carbon-aggregator', ''
  end

  it 'configures carbon' do
    expect(chef_run).to create_file_with_content "/opt/graphite/conf/carbon.conf", ''
  end

  it 'configures storage schemas' do
    expect(chef_run).to create_file_with_content "/opt/graphite/conf/storage-schemas.conf", ''
  end

  it 'configures storage aggregation' do
    expect(chef_run).to create_file_with_content "/opt/graphite/conf/storage-aggregation.conf", ''
  end

  it 'configures relay rules' do
    expect(chef_run).to create_file_with_content "/opt/graphite/conf/relay-rules.conf", ''
  end

  it 'configures aggregation rules' do
    expect(chef_run).to create_file_with_content "/opt/graphite/conf/aggregation-rules.conf", ''
  end

  it 'configures whitelist' do
    expect(chef_run).to create_file_with_content "/opt/graphite/conf/whitelist.conf", ''
  end

  it 'configures blacklist' do
    expect(chef_run).to create_file_with_content "/opt/graphite/conf/blacklist.conf", ''
  end

  it 'enables and starts carbon-cache' do
    chef_runner.node.set['graphite']['carbon']['enable_cache'] = true
    chef_run = chef_runner.converge 'graphite::configure_carbon'
    expect(chef_run).to start_service 'carbon-cache'
    expect(chef_run).to set_service_to_start_on_boot 'carbon-cache'
  end

  it 'enables and starts carbon-relay' do
    chef_runner.node.set['graphite']['carbon']['enable_relay'] = true
    chef_run = chef_runner.converge 'graphite::configure_carbon'
    expect(chef_run).to start_service 'carbon-relay'
    expect(chef_run).to set_service_to_start_on_boot 'carbon-relay'
  end

  it 'enables and starts carbon-aggregator' do
    chef_runner.node.set['graphite']['carbon']['enable_aggregator'] = true
    chef_run = chef_runner.converge 'graphite::configure_carbon'
    expect(chef_run).to start_service 'carbon-aggregator'
    expect(chef_run).to set_service_to_start_on_boot 'carbon-aggregator'
  end
end
