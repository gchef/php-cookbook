apt_package "php5-xmlrpc" do
  version "#{node[:php][:version]}*"
  freeze true
end

create_extension "xmlrpc"
