require 'chefspec'

describe 'graphite::configure_webapp' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path)
  end

  let(:chef_run) do
    chef_runner.converge 'graphite::configure_webapp'
  end
  
  it 'creates an init script' do
    expect(chef_run).to create_file_with_content '/etc/init.d/graphite-webapp', ''
  end

  it 'sets up django database' do
    expect(chef_run).to execute_command('python manage.py syncdb --noinput').with(:cwd => "/opt/graphite/webapp/graphite")
  end

  it 'allows graphite-webapp to read/write the storage directory' do
    expect(chef_run).to execute_command "chown -R graphite:graphite /opt/graphite/storage"
  end

  it 'configures local_settings.py' do
    expect(chef_run).to create_file_with_content "/opt/graphite/webapp/graphite/local_settings.py", ''
  end

  it 'configures the dashboard' do
    expect(chef_run).to create_file_with_content "/opt/graphite/conf/dashboard.conf", ''
  end

  it 'configures the graph templates' do
    expect(chef_run).to create_file_with_content "/opt/graphite/conf/graphTemplates.conf", ''
  end

  it 'enables and starts graphite-webapp' do
    expect(chef_run).to start_service 'graphite-webapp'
    expect(chef_run).to set_service_to_start_on_boot 'graphite-webapp'
  end
end
