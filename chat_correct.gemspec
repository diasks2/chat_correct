# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chat_correct/version'

Gem::Specification.new do |spec|
  spec.name          = "chat_correct"
  spec.version       = ChatCorrect::VERSION
  spec.authors       = ["Kevin S. Dias"]
  spec.email         = ["diasks2@gmail.com"]
  spec.summary       = %q{Returns the errors and error types when an incorrect English sentence is diffed with a correct English sentence.}
  spec.description   = %q{A Ruby gem to help students improve their English. A teacher can correct a student's sentence and this gem will automatically provide information on the type of error (i.e. punctuation, spelling, etc.), the placement of the errors, and the number of errors.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.1.0'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "text"
  spec.add_runtime_dependency "linguistics", "~> 2.0.2"
  spec.add_runtime_dependency "verbs"
  spec.add_runtime_dependency "engtagger"
end
