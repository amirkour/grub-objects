require 'mongooz'

class Ingredients<Mongooz::MongoozHash

	# every ingredient has a name
	property :name

	# and a list of composite ingredients (which not all ingredients will have.)
	# expected to be a list of hashes:
	# [{:name=>"comp1", :composites=>[{...},{...},...]}, {:name=>"comp2", :composites=>[ ... ]}]
	property :composites

	def initialize(init_hash=nil, *args, &block)
		super
		return unless init_hash.kind_of?(Hash)

		# if the init hash just came from mongo, it'll be a hash, but it won't be a HashWithIndifferentAccess.
		# make it one, because mongo doesn't store symbols and i don't wanna worry about whether the
		# keys are strings or symbols
		init_hash=HashWithIndifferentAccess.new(init_hash) unless init_hash.kind_of?(HashWithIndifferentAccess)

		# wrap the composites up as Ingredients objects
		if init_hash[:composites].kind_of?(Array)
			self.composites=init_hash[:composites].map{ |new_composite| Ingredients.new(new_composite) }
		end
	end

	alias_method :old_db_insert, :db_insert
	def db_insert(options={})
		self.name=self.name.downcase unless self.name.nil?
		old_db_insert(options)
	end

	# private

	# def raise_error_if_loop_detected(ingredient_as_hash, skip_db_audit=true)
	# 	return unless ingredient_as_hash.kind_of?(Hash) && ingredient_as_hash[:name]

	# 	# use this helper to enqueue the given composites onto the given queue
	# 	enqueue_helper=lambda do |queue, composites|
	# 		if composites.kind_of?(Array)
	# 			composites.each do |composite_as_hash|
	# 				queue << composite_as_hash[:name].downcase unless composite_as_hash[:name].nil?
	# 			end
	# 		end
	# 	end

	# 	# breadth-first style traversal - queue up this ingredient and all it's composites
	# 	queue=[ingredient_as_hash[:name].downcase]
	# 	enqueue_helper.call(queue, ingredient_as_hash[:composites])
		
	# 	visited_ingredient_names={}
	# 	until queue.empty?
	# 		next_ingredient=queue.shift
	# 		raise "loop detected at ingredient #{next_ingredient}" if visited_ingredient_names[next_ingredient]
	# 		visited_ingredient_names[next_ingredient]=true

	# 		# you can do a comprehensive data audit by specifying skip_db_audit=false
	# 		unless skip_db_audit
	# 			next_ingredient_as_object=Ingredients.db_query({:name=>next_ingredient})
	# 			enqueue_helper.call(queue, next_ingredient_as_object.composites)
	# 		end
	# 	end
	# end
end
