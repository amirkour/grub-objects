require 'grub-objects'

Mongooz.defaults(:db=>'grub_test')

describe Ingredients do
	describe "#db_insert" do
		before :all do
			@test_ingredient=Ingredients.new
			@test_ingredient_name="FOO"
			@test_ingredient.name=@test_ingredient_name
			@test_ingredient.db_insert
		end
		after :all do
			@test_ingredient.db_delete
		end

		it "lowercases the ingredient name" do
			expect(@test_ingredient.name).to_not eq(@test_ingredient_name)
			expect(@test_ingredient.name).to eq(@test_ingredient_name.downcase)
		end

		it "doesn't allow dupe ingredient names" do
			dupe=Ingredients.new
			dupe.name=@test_ingredient_name
			expect{dupe.db_insert}.to raise_error
		end
	end
	describe "#==" do
		it "returns true for the same object" do
			a=Ingredients.new :name=>"foo", :composites=>[{:name=>"bar"}]
			b=a
			expect(a).to eq(b)
		end
		it "returns true for two hashes that are ==" do
			a=Ingredients.new :name=>"foo", :composites=>[{:name=>"bar"}]
			b=Ingredients.new :name=>"foo", :composites=>[{:name=>"bar"}]
			expect(a).to eq(b)
		end
		it "returns true symmetrically" do
			a=Ingredients.new :name=>"foo", :composites=>[{:name=>"bar"}]
			b=Ingredients.new :name=>"foo", :composites=>[{:name=>"bar"}]
			expect(a).to eq(b)
			expect(b).to eq(a)
		end
		it "returns false when comparing an ingredient to a non-ingredient" do
			a=Ingredients.new :name=>"foo", :composites=>[{:name=>"bar"}]
			b=Object.new
			expect(a).to_not eq(b)
		end
		it "returns false if two ingredients are not equal" do
			a=Ingredients.new :name=>"foo", :composites=>[{:name=>"bar"}]
			b=Ingredients.new :name=>"foo", :composites=>[{:name=>"baz"}]
			expect(a).to_not eq(b)
		end
		it "returns false symmetrically" do
			a=Ingredients.new :name=>"foo", :composites=>[{:name=>"bar"}]
			b=Ingredients.new :name=>"foo", :composites=>[{:name=>"baz"}]
			expect(a).to_not eq(b)
			expect(b).to_not eq(a)
		end
	end
	describe "#eql?" do
		it "returns true for the same object" do
			a=Ingredients.new :name=>"foo", :composites=>[{:name=>"bar"}]
			b=a
			expect(a).to eql(b)
		end
		it "returns true for two hashes that are ==" do
			a=Ingredients.new :name=>"foo", :composites=>[{:name=>"bar"}]
			b=Ingredients.new :name=>"foo", :composites=>[{:name=>"bar"}]
			expect(a).to eql(b)
		end
		it "returns true symmetrically" do
			a=Ingredients.new :name=>"foo", :composites=>[{:name=>"bar"}]
			b=Ingredients.new :name=>"foo", :composites=>[{:name=>"bar"}]
			expect(a).to eql(b)
			expect(b).to eql(a)
		end
		it "returns false when comparing an ingredient to a non-ingredient" do
			a=Ingredients.new :name=>"foo", :composites=>[{:name=>"bar"}]
			b=Object.new
			expect(a).to_not eql(b)
		end
		it "returns false if two ingredients are not equal" do
			a=Ingredients.new :name=>"foo", :composites=>[{:name=>"bar"}]
			b=Ingredients.new :name=>"foo", :composites=>[{:name=>"baz"}]
			expect(a).to_not eql(b)
		end
		it "returns false symmetrically" do
			a=Ingredients.new :name=>"foo", :composites=>[{:name=>"bar"}]
			b=Ingredients.new :name=>"foo", :composites=>[{:name=>"baz"}]
			expect(a).to_not eql(b)
			expect(b).to_not eql(a)
		end
	end
end
