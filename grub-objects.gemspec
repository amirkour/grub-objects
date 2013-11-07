Gem::Specification.new do |s|
	s.name="grub-objects"
	s.version="0.0.1"
	s.authors=["amir kouretchian"]
	s.date="2013-11-05"
	s.description="Object models and their specs for grubalub.com"
	s.summary=s.description
	s.files=%w(README.md).concat(Dir.glob("**/*.rb"))
	s.add_dependency('mongooz')
end
