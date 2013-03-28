banalizer File.basename(__FILE__, '.rb').to_sym do

  synopsis '-- This is example template of the Ruby policy file -- ' 
  severity :brutal
  style    :cosmetic

description <<-DESC

Give a description here

DESC

  default some_default: 30

  def run

    # DSL methods accessors can be used:
    # ----------------------
    # lines
    # shebang
    # code
    # comments
    # variables

    # DSL checks
    # ----------------------
    # code.has? 
    # comments.have? 
    # variables.dont_have?
    #
    # Search result
    # ----------------------
    # code.lines
    
    errors.add "Code size is 0" if code.size == 0

    errors.add "Les than default" unless default[:some_default] < 30

    errors.empty? # Return result
  end

end
