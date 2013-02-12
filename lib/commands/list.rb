desc 'List available policies'

arg_name ''
command :list do |c|
  c.desc 'Describe a switch to list'
  c.switch :s

  c.desc 'Describe a flag to list'
  c.default_value 'default'
  c.flag :f
  c.action do |global_options,options,args|

    # Your command logic here
     
    # If you have any errors, just raise them
    # raise "that command made no sense"

    puts "list command ran"
  end
end
