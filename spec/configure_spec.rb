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
    'webapp'
  ].each do |install_mode|
    context "with install target #{install_mode}" do
      it 'configures carbon' do
        chef_runner.node.set['graphite']['install_carbon'] = (install_mode == 'both' or install_mode == 'carbon')
        chef_runner.node.set['graphite']['install_webapp'] = (install_mode == 'both' or install_mode == 'webapp')
        chef_run = chef_runner.converge 'graphite::configure'
        
        expect(chef_run).to include_recipe 'graphite::configure_carbon' if install_mode == 'both' or install_mode == 'carbon'
      end

      it 'configures graphite-web' do
        chef_runner.node.set['graphite']['install_carbon'] = (install_mode == 'both' or install_mode == 'carbon')
        chef_runner.node.set['graphite']['install_webapp'] = (install_mode == 'both' or install_mode == 'webapp')
        chef_run = chef_runner.converge 'graphite::configure'
        
        expect(chef_run).to include_recipe 'graphite::configure_webapp' if install_mode == 'both' or install_mode == 'webapp'
      end
    end
  end
end
