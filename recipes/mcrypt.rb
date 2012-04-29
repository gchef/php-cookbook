apt_package "php5-mcrypt" do
  freeze true
end

create_extension "mcrypt"
