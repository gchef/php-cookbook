apt_package "php5-mysql" do
  version "#{node[:php][:version]}*"
  freeze true
end

create_extension "mysql"
create_extension "mysqli"
create_extension "pdo_mysql"
