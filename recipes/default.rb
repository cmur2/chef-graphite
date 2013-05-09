
include_recipe 'python'

# create graphite user and group
user node['graphite']['user']
group node['graphite']['group'] do
  members [node['graphite']['user']]
end

# create runfiles directory
directory "/var/run/graphite" do
  owner node['graphite']['user']
  group node['graphite']['group']
  mode 00755
end

include_recipe 'graphite::install'
include_recipe 'graphite::configure'
