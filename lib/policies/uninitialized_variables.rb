banalizer File.basename(__FILE__, '.rb').to_sym do

  synopsis '' 
  severity :gentle
  style    :security

  description <<-DESC

Variable initialization
------------------------

As in C, it's always a good idea to initialize your variables, though,
the  shell  will  initialize  fresh variables  itself  (better:  Unset
variables   will  generally   behave  like   variables   containing  a
nullstring).

It's  no problem  to pass  a variable  you use  as environment  to the
script. If you blindly assume that all variables you use are empty for
the first time, somebody can inject a variable content by just passing
it in the environment.

The solution is simple and effective: Initialize them

my_input=""
my_array=()
my_number=0

If you do that  for every variable you use, then you  also have a kind
of documentation for them.

Ref: http://wiki.bash-hackers.org/scripting/style#variable_initialization

DESC
  
  default some_default: 30

  def run

    variables.each do |var|
      errors.add "Variable ${#{var}} used without initializing" if 
        code.dont_have? /#{var}=/
    end

    errors.empty?
  end

end
