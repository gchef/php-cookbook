require_recipe "apt"

apt_repository "php5" do
  uri node[:php][:apt][:uri]
  keyserver node[:php][:apt][:keyserver]
  key node[:php][:apt][:key]
end

if Chef::Extensions.wan_up?
  node[:php][:core_packages].each do |name|
    apt_package name do
      version "#{node[:php][:version]}*"
      keep_conf true
      freeze true
    end
  end

  php_pear_channel 'pear.php.net' do
    action :update
  end

  php_pear_channel 'pecl.php.net' do
    action :update
  end
end

template "#{node[:php][:conf_dir]}/cli/php.ini" do
  source "cli.php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  backup false
end

directory "#{node[:php][:extensions_dir]}" do
  owner "root"
  group "root"
  mode "0755"
end
