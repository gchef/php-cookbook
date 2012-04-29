apt_package "php5-suhosin" do
  freeze true
end

create_extension "suhosin"

template "#{node[:php][:ext_conf_dir]}/suhosin.ini" do
  owner "root"
  group "root"
  mode "0644"
  backup false
end
