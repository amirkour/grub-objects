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
end
