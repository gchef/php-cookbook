action :create do
  service "php5-fpm" do
    supports(
      :reload  => true,
      :restart => true,
      :start   => true,
      :status  => true,
      :stop    => true
    )
  end

  template "/etc/php5/fpm/pool.d/#{new_resource.name}.conf" do
    cookbook "php"
    source "fpm_pool.conf.erb"
    owner "root"
    group "root"
    mode "0640"
    variables(
      :pool => new_resource
    )
    notifies :reload, resources(:service => "php5-fpm"), :delayed
  end
end

action :delete do
  file "/etc/php5/fpm/pool.d/#{new_resource.name}.conf" do
    action :delete
    notifies :reload, resources(:service => "php5-fpm"), :delayed
  end

  bash "delete all php-fpm pool logs for #{new_resource.name}" do
    code "rm -f /var/log/php-fpm/#{new_resource.name}*"
  end
end
