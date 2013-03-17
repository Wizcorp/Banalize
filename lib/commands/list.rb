desc 'List available policies'

command [:list, :ls] do |c|

  c.desc 'Only names of policies without description'
  c.switch [:short, :s]
  c.default_value true

  c.action do |global, options, args|

    
    printf "\n%40s   %s\n\n", "Policy name".color(:bold), "Synopsis, style, severity".color(:bold)

    $policies.each do |x|
      if options[:short]
        printf "%40s : %s, %s\n", x[:policy].to_s.color(:yellow), x[:style], x[:severity]
      else
        printf "%40s : %s [%s, %s]\n", x[:policy].to_s.color(:yellow), x[:synopsis], x[:style], x[:severity]
      end
    end
  end
end
