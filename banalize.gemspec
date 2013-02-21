# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','banalize','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'banalize'
  s.version = Banalize::VERSION
  s.author = 'Dmytro Kovalov'
  s.email = 'dmytro.kovalov@gmail.com'
  s.homepage = 'http://wizcorp.jp'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Static syntax analyzer for Bash'
  s.description = "Run policies tests on bash scripts and libraries with specified policies and severity"

  s.files = ( %w{ bin/banalize } + 
              Dir.glob("./lib/**/*.rb") + 
              Dir.glob("./lib/policies/**/*")
             ).uniq

  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = Dir.glob("*.(rdoc|md)")
  s.rdoc_options << '--title' << 'Banalize' << '--main' << 'README.md' << '-ri'
  s.bindir = 'bin'
  s.executables << 'banalize'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.5.4')
end
