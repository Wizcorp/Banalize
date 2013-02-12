# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','banalize','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'banalize'
  s.version = Banalize::VERSION
  s.author = 'Dmytro Kovalov'
  s.email = 'dmytro.kovalov@gmail.com'
  s.homepage = 'http://wizcorp.jp'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Statc syntax analyzer for Bash'
# Add your other files here if you make them
#   s.files = %w(
# bin/banalize
# lib/banalize/version.rb
# lib/banalize.rb
#   )
  s.files = %w{ bin/banalize } + Dir.glob("./lib/**/*.rb")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','Banalize.rdoc']
  s.rdoc_options << '--title' << 'Banalize' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'banalize'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.5.4')
end
