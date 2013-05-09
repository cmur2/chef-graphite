
case node[:platform]
when 'debian'
  case node[:platform_version].to_i
  when 6
    dep_pkgs = %w[python-cairo python-django python-django-tagging python-memcache python-pysqlite2 python-rrdtool python-simplejson python-twisted]
  end
end

dep_pkgs.each do |p|
  package p
end

dep_pip_pkgs = %w[whsiper txamqp]
dep_pip_pkgs.each do |p|
  python_pip p do
    action :install
  end
end

if node['graphite']['install_target'] == 'both' or node['graphite']['install_target'] == 'carbon'
  python_pip 'carbon' do
    action :install
  end
end

if node['graphite']['install_target'] == 'both' or node['graphite']['install_target'] == 'graphite-web'
  python_pip 'graphite-web' do
    action :install
  end
end
