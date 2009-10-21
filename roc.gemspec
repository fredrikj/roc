## roc.gemspec
#

Gem::Specification::new do |spec|
  spec.name = "roc"
  spec.description = 'Receiver operator characteristic (ROC)' 
  spec.version = "0.0.0"
  spec.platform = Gem::Platform::RUBY
  spec.summary = "roc"

  spec.files = ["roc.gemspec", "lib", "lib/roc.rb", "README", "samples", "samples/a.rb", "test", "test/roc.rb"]
  spec.executables = []
  
  spec.require_path = "lib"

  spec.has_rdoc = true
  spec.test_files = "test/roc.rb"

  spec.extensions.push(*[])

  spec.rubyforge_project = "roc"
  spec.author = "Fredrik Johansson"
  spec.email = "fredjoha@gmail.com"
  spec.homepage = "http://github.com/fredrikj/roc/tree/master"
end
