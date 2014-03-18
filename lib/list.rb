require 'pg'

class List
  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
    @tasks = []
  end

  def name
    @name
  end

  def tasks
    @tasks
  end

  def ==(another_list)
    self.name == another_list.name
  end

  def self.all
    results = DB.exec("SELECT * FROM lists;")
    lists = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      lists << List.new({:name => name, :id => id})
    end
    lists
  end

  def save
    results = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def id
    @id
  end
end
