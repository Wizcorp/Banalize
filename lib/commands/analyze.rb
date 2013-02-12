desc 'Describe analyze here'
arg_name 'Describe arguments to analyze here'
command :analyze do |c|
  c.action do |global_options,options,args|
    puts "analyze command ran"
  end
end
