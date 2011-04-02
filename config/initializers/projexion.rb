require 'yaml'

APPLICATION = YAML.load_file("#{Rails.root}/config/projexion.yml").symbolize_keys
KEYWORD_FILTER_MATCHER = /[^a-zA-Z0-9\-]+/