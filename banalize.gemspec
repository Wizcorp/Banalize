# Ensure we require the local version and not one we might have installed already
spec = Gem::Specification.new do |s| 
  s.name = 'banalize'
  s.version = File.read('version.txt').chomp.strip
  s.author = 'Dmytro Kovalov'
  s.email = 'dmytro.kovalov@gmail.com'
  s.homepage = 'http://wizcorp.jp'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Static syntax analyzer for Bash'
  s.description = "Run policies tests on bash scripts and libraries with specified policies and severity"

  s.files = ( %w{ bin/banalize version.txt} + 
              Dir.glob("*.md") +
              Dir.glob("./lib/**/*.rb") + 
              Dir.glob("./lib/policies/**/*")
             ).uniq

  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = Dir.glob("*.(rdoc|md)")
  s.rdoc_options << '--title' << 'Banalize' << '--main' << 'README.md' << '-ri'
  s.bindir = 'bin'
  s.executables << 'banalize'

  s.add_dependency('mash')
  s.add_dependency('gli','2.5.4')
  s.add_dependency('activesupport','~>3.2.13')

  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_development_dependency('redcarpet')
  s.add_development_dependency('rspec-core')
  s.add_development_dependency('rspec-mocks')
  s.add_development_dependency('rspec-expectations')
  s.add_development_dependency('yard')

end
