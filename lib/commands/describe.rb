desc 'Give a description of terms used here'
arg_name 'Describe arguments to analyze here'
command [:describe,:desc] do |c|


  c.desc 'Print help for the specified policy'
  c.command [:policy, :pol, :p] do |p|

    def yellow
      printf "%s\n", ('~' * 80).color(:yellow)
    end

    p.action do |global_options, options, args|
      $policies.each do |pol|

        yellow
        printf "%s :  %s\n", pol[:policy].to_s.color(:bold), pol[:synopsis].color(:green)
        yellow

        puts pol[:description]
        puts
      end
    end

  end
  

  ##
  # Policies
  #
  c.desc 'List and describe available policy groups'
  c.command [:styles, :style] do |p|
    p.action do
      puts <<-EOP
Theme        Description
-----        ----------- 
core         All policies
bugs         Policies that that prevent or reveal bugs
maintenance  Policies that affect the long-term health of the code
cosmetic     Policies that only have a superficial effect
complexity   Policies that specifically relate to code complexity
security     Policies that relate to security issues
tests        Policies that are specific to test programs

EOP
    end
  end



  ##
  # Severity
  #
  c.desc 'Print out names of severity levels and their numeric value'
  c.command [:severity, :sev] do |a|
    a.action do 
      puts "Name                Value"
      puts "------              ------"
      print Banalize::Policy::Severity.to_s

      puts "\n\nDefault severity: " << Banalize::Policy::Severity.default.to_s
    end
  end

end
