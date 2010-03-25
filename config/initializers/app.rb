require 'yaml'

APPLICATION = YAML.load_file("#{Rails.root}/config/app.yml").symbolize_keys