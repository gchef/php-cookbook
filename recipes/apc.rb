apt_package "php-apc" do
  freeze true
end

create_extension "apc"
