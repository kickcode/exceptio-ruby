# -*- encoding: utf-8 -*-
# stub: exceptio-ruby 0.1.7.pre ruby lib

Gem::Specification.new do |s|
  s.name = "exceptio-ruby"
  s.version = "0.1.7.pre"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Elliott Draper"]
  s.date = "2014-11-06"
  s.email = "el@kickcode.com"
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc", "lib/exceptio", "lib/exceptio-ruby.rb", "lib/exceptio.rb", "lib/exceptio/client.rb", "lib/exceptio/hooks.rb"]
  s.homepage = "http://github.com/kickcode/exceptio-ruby"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.rubygems_version = "2.2.2"
  s.summary = "Ruby client library for the ExceptIO error notification service, with Rails 2.3/Rails 3 hooks"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, ["> 0.8.1"])
      s.add_development_dependency(%q<fakeweb>, ["~> 1.3.0"])
      s.add_development_dependency(%q<mocha>, ["~> 0.10.0"])
    else
      s.add_dependency(%q<httparty>, ["> 0.8.1"])
      s.add_dependency(%q<fakeweb>, ["~> 1.3.0"])
      s.add_dependency(%q<mocha>, ["~> 0.10.0"])
    end
  else
    s.add_dependency(%q<httparty>, ["> 0.8.1"])
    s.add_dependency(%q<fakeweb>, ["~> 1.3.0"])
    s.add_dependency(%q<mocha>, ["~> 0.10.0"])
  end
end
