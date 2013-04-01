
file "docs/policies.md"

task "docs/policies.md" => Dir.glob('lib/**/*') do
  sh "bundle exec ./bin/banalize describe policy --markdown > docs/policies.md"
end

desc "Generate YARD documentation"
task :doc => ["docs/policies.md"]do 
  sh "yard"
end

namespace :doc do 
  
  desc "Push documentation to gh pages"
  task :push => :doc do
    sh "(cd doc && git add . && git commit -m 'generated docs' && git push origin gh-pages)"
  end


  namespace :push do 
    
    desc "Push to upstream repo"
    task :upstream => "doc:push" do 
      sh "(cd doc && git push upstream gh-pages)"
    end

  end


end

# require 'rake/clean'
# require 'rubygems'
# require 'rubygems/package_task'
# require 'rdoc/task'
# require 'cucumber'
# require 'cucumber/rake/task'
# Rake::RDocTask.new do |rd|
#   rd.main = "README.rdoc"
#   rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
#   rd.title = 'Your application title'
# end

# spec = eval(File.read('Banalize.gemspec'))

# Gem::PackageTask.new(spec) do |pkg|
# end
# CUKE_RESULTS = 'results.html'
# CLEAN << CUKE_RESULTS
# desc 'Run features'
# Cucumber::Rake::Task.new(:features) do |t|
#   opts = "features --format html -o #{CUKE_RESULTS} --format progress -x"
#   opts += " --tags #{ENV['TAGS']}" if ENV['TAGS']
#   t.cucumber_opts =  opts
#   t.fork = false
# end

# desc 'Run features tagged as work-in-progress (@wip)'
# Cucumber::Rake::Task.new('features:wip') do |t|
#   tag_opts = ' --tags ~@pending'
#   tag_opts = ' --tags @wip'
#   t.cucumber_opts = "features --format html -o #{CUKE_RESULTS} --format pretty -x -s#{tag_opts}"
#   t.fork = false
# end

# task :cucumber => :features
# task 'cucumber:wip' => 'features:wip'
# task :wip => 'features:wip'
# require 'rake/testtask'
# Rake::TestTask.new do |t|
#   t.libs << "test"
#   t.test_files = FileList['test/*_test.rb']
# end

# task :default => [:test,:features]
