apt_package "php5-pgsql" do
  version "#{node[:php][:version]}*"
  freeze true
end

create_extension "pgsql"
