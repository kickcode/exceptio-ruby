# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{exceptio-ruby}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Elliott Draper"]
  s.date = %q{2011-07-15}
  s.email = %q{el@kickcode.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["exceptio-ruby.rb", "README.rdoc", "lib/exceptio/client.rb", "lib/exceptio/engine.rb", "lib/exceptio/hooks.rb", "lib/exceptio.rb"]
  s.homepage = %q{http://except.io/ruby}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Ruby client library for the ExceptIO error notification service, with Rails 2.3/Rails 3 hooks}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
    else
      s.add_dependency(%q<httparty>, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0"])
  end
end
