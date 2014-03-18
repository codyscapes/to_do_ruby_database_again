require './lib/task'
require './lib/list'
require 'pg'

 DB = PG.connect(:dbname => 'to_do')
