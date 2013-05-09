require 'chefspec'

describe 'graphite::configure' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path)
  end

  let(:chef_run) do
    chef_runner.converge 'graphite::configure'
  end
  
  [
    'both',
    'carbon',
    'graphite-web'
  ].each do |install_mode|
    context "with install target #{install_mode}" do
      it 'configures carbon' do
        chef_runner.node.set['graphite']['install_mode'] = install_mode
        chef_run = chef_runner.converge 'graphite::configure'
        
        expect(chef_run).to include_recipe 'graphite::configure_carbon' if install_mode == 'both' or install_mode == 'carbon'
      end

      it 'configures graphite-web' do
        chef_runner.node.set['graphite']['install_mode'] = install_mode
        chef_run = chef_runner.converge 'graphite::configure'
        
        expect(chef_run).to include_recipe 'graphite::configure_webapp' if install_mode == 'both' or install_mode == 'graphite-web'
      end
    end
  end
end
