require "rubygems"
require "rubygems/package_task"
require "rdoc/task"

task :default => :package

spec = Gem::Specification.new do |s|

  s.name              = "exceptio-ruby"
  s.version           = "0.1.0"
  s.summary           = "Ruby client library for the ExceptIO error notification service, with Rails 2.3/Rails 3 hooks"
  s.author            = "Elliott Draper"
  s.email             = "el@kickcode.com"
  s.homepage          = "http://except.io/ruby"

  s.has_rdoc          = true
  s.extra_rdoc_files  = %w(README.rdoc)

  s.files             = %w(exceptio-ruby.rb README.rdoc) + Dir.glob("{lib}/**/*")
  s.require_paths     = ["lib"]

  s.add_dependency("httparty")
end

Gem::PackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Build the gemspec file #{spec.name}.gemspec"
task :gemspec do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, "w") {|f| f << spec.to_ruby }
end

task :package => :gemspec

RDoc::Task.new do |rd|
  rd.rdoc_files.include("lib/**/*.rb")
  rd.rdoc_dir = "rdoc"
end

desc 'Clear out RDoc and generated packages'
task :clean => [:clobber_rdoc, :clobber_package] do
  rm "#{spec.name}.gemspec"
end
