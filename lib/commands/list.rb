desc 'List available policies'

arg_name ''
command :list do |c|

  c.desc 'Only names of policies without description'
  c.switch [:short, :s]
  c.default_value true

  c.action do |global_options,options,args|

    print case 

          when options[:short]
            Banalize::Files.policies.map { |x| {x[:name] => [x[:policy], x[:severity]]} }

          else
            Banalize::Files.policies.map { |x|
        { 
          name: x[:name],
          description: x[:description],
          policy: x[:policy],
          severity: x[:severity],
        }
      }

    end.to_yaml
    
  end
end
