# Helper which will load all extensions defined in the array
#
node[:php][:extensions].each do |name|
  include_recipe "php::#{name}"
end
