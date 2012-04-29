apt_package "php5-gd" do
  version "#{node[:php][:version]}*"
  freeze true
end

create_extension "gd"
