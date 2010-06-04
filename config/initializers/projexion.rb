require 'yaml'

APPLICATION = YAML.load_file("#{Rails.root}/config/projexion.yml").symbolize_keys