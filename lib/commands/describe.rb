desc 'Give a description of terms used here'
arg_name 'Describe arguments to analyze here'
command [:describe,:desc] do |c|


  c.desc 'Print help for the specified policy'
  c.command [:policy, :pol, :p] do |p|
    p.desc 'Policy name'
    p.arg_name 'policy_name'
    # p.flag [:policy, :p]

    p.action do |global_options,options,args|
      print "Name: #{options[:policy]}\n\n"
      print Banalize::Policy.description(args.first.to_sym) + "\n\n"
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
