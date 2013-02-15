desc 'Give a description of terms used here'
arg_name 'Describe arguments to analyze here'
command :describe do |c|


  ##
  # Policies
  #
  c.desc 'List and describe available policies'
  c.command :policy do |p|
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
  c.command :severity do |a|
    a.action do 
      puts <<-EOF

Name          Value
------        -------------
Gentle        (5) - default
Stern         (4)
Harsh         (3)
Cruel         (2)
Brutal        (1)

EOF
    end
  end

#   c.action do |global_options,options,args|
#     puts "analyze command ran"
#   end
end
