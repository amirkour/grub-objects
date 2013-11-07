require 'mongooz'

class Ingredients<Mongooz::MongoozHash
	alias_method :old_db_insert, :db_insert
	def db_insert(options={})
		self[:name]=self[:name].downcase if self[:name]
		old_db_insert(options)
	end
end
