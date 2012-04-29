service "apache2"

apt_package "libapache2-mod-php5" do
  version "#{node[:php][:version]}*"
  freeze true
end

apache_module "php5"

template "/etc/php5/apache2/php.ini" do
  source "apache2.php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "apache2"), :delayed
end
