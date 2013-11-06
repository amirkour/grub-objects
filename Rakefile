task :default=>:dev

# during dev, auto-rebuild please
task :dev=>[:rebuild,:test]{ puts "DEV MODE HOOOO!" }

# during prod - i dunno, do cool stuff
# TODO
task :prod do
	puts "I'm unimplemente thank you very much!"
end

task :test do
	puts "Testing"
	system "rspec specs/ingredients-spec.rb"
end

task :rebuild => :clean do
	puts "Rebuilding ..."
	system "gem build grub-objects.gemspec"
	system "gem install grub-objects-0.0.1.gem"#todo - version on cmd-line maybe?
end

task :clean do
	puts "Cleaning ..."
	# TODO - uninstall the gem every time?
end
