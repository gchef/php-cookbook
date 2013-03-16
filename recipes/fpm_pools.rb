node[:php][:fpm][:pools].each do |pool|
  php_fpm_pool pool.delete(:name) do
    pool.each do |attribute, value|
      instance_variable_set("@#{attribute}", value)
    end
  end
end
