apt_package "php5-sqlite" do
  version "#{node[:php][:version]}*"
  freeze true
end

create_extension "sqlite"
