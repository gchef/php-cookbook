apt_package "php5-memcache" do
  freeze true
end

create_extension "memcache"
