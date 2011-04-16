require 'data_mapper'

DataMapper.setup( :default, "sqlite3:///home/ambre/wShorten/wShorten.db" )

require_relative '../models/urlRedir'

DataMapper.finalize

DataMapper::Model.raise_on_save_failure = true

