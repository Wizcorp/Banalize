desc 'Run banalize on single file'

arg_name 'TODO'
command :file do |c|
  c.action do |global_options,options,args|
    puts "file command ran"
  end
end
