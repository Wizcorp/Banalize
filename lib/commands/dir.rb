desc 'Run banalize in derectory with bash files'

arg_name ''
command :dir do |c|
  c.action do |global_options,options,args|
    puts "file command ran"
  end
end
