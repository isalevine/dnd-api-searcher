require 'bundler'
Bundler.require

require_all 'app'
require_all 'bin'
require_all 'lib'

db_config = YAML.load_file('config/database.yml')
ActiveRecord::Base.establish_connection(db_config['development'])
