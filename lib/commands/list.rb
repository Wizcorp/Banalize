desc 'List available policies'

command [:list, :ls] do |c|

  c.desc 'Only names of policies without description'
  c.switch [:short, :s]
  c.default_value true

  c.action do |global, options, args|

    print case

          when options[:short]
            $policies.map { |x| { x[:policy] => [x[:style], x[:severity]] } }

          else
            $policies.map { |x|
        {
          x[:policy] => [x[:synopsis], x[:style], x[:severity]],
        }
      }

    end.to_yaml

  end
end
