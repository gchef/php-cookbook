apt_package "php5-curl" do
  version "#{node[:php][:version]}*"
  freeze true
end

create_extension "curl"
