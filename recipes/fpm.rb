wan_up = `host -W 1 google.com`.index(/has address/)

if wan_up
  apt_package "php5-fpm" do
    version "#{node[:php][:version]}*"
    keep_conf true
    freeze true
  end

  service "php5-fpm" do
    supports :status => true, :restart => true, :reload => true, :stop => true, :start => true
  end

  file "/var/log/php5-fpm.log" do
    action :delete
  end

  template "/etc/php5/fpm/php.ini" do
    source "fpm.php.ini.erb"
    owner "root"
    group "root"
    mode "0644"
    notifies :restart, resources(:service => "php5-fpm"), :delayed
  end

  directory node[:php][:fpm][:log_dir] do
    owner node[:php][:fpm][:www][:user]
    group node[:php][:fpm][:www][:group]
    mode "0700"
  end

  template "/etc/php5/fpm/php-fpm.conf" do
    owner "root"
    group "root"
    mode "0644"
    notifies :restart, resources(:service => "php5-fpm"), :delayed
  end

  template "/etc/php5/fpm/pool.d/www.conf" do
    owner "root"
    group "root"
    mode "0644"
    notifies :restart, resources(:service => "php5-fpm"), :delayed
  end

  template "/etc/init.d/php5-fpm" do
    source "php5-fpm.sysv.erb"
    mode "0754"
    notifies :restart, resources(:service => "php5-fpm"), :delayed
  end

  service "php5-fpm" do
    action [:enable, :start]
  end
end
