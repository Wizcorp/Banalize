banalizer File.basename(__FILE__, '.rb').to_sym do

  synopsis 'Always use braces to isolate variables ${a}' 
  severity :stern
  style    :bugs

  description <<-DESC

Use braces around variables
---------------------------

To prevent wrong expansion of variables always use braces around
variables. I.e.

Good: ${VARIABLE}
Bad:  $VARIABLE

foo=sun
echo $fooshine     # $fooshine is undefined
echo ${foo}shine   # displays the word "sunshine"

DESC
  
  def run

    variables.each do |var|

      if code.has?(/\$#{var}/)
        errors.add "Variable $#{var} used without braces" 
        errors.add "    Lines: #{code.lines}"
      end
    end

    errors.empty?
  end

end
