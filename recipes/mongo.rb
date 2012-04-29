php_pear "mongo" do
  action :install
end

create_extension "mongo" do
  provider "pear"
end
