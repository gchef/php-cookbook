apt_package "php5-geoip" do
  freeze true
end

create_extension "geoip"
