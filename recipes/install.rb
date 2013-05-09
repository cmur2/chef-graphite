
# Installs required packages for graphite to be installed via pip

dep_pkgs = %w[python-cairo python-django python-django-tagging python-memcache python-pysqlite2 python-rrdtool python-simplejson python-twisted]
dep_pkgs.each do |p|
  package p
end

package 'whisper' do
  provider Chef::Provider::PythonPip
end

#python_pip 'whisper' do
  #action :install
#end
