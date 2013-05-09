require 'chefspec'

describe 'graphite::configure_carbon' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path)
  end

  let(:chef_run) do
    chef_runner.converge 'graphite::configure_carbon'
  end
  
  it 'creates an init script' do
    expect(chef_run).to create_file_with_content '/etc/init.d/carbon-cache', ''
  end

  it 'configures carbon' do
    expect(chef_run).to create_file_with_content "/opt/graphite/conf/carbon.conf", ''
  end

  it 'configures storage schemas' do
    expect(chef_run).to create_file_with_content "/opt/graphite/conf/storage-schemas.conf", ''
  end

  it 'enables and starts carbon-cache' do
    expect(chef_run).to start_service 'carbon-cache'
    expect(chef_run).to set_service_to_start_on_boot 'carbon-cache'
  end
end
