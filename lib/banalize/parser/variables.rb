module Banalize
  class Parser

    ##
    # Parse and detect all shell variables used in script. Set
    # instance level accessor `variables`.
    #
    module ShellVariables
      
      ##
      # Parse and detect all shell variables  used in script.
      #
      # @return [Array] 
      def shell_variables
        ln = code.grep(/\$\{?\w+\}?/).map(&:last).join " "

        vars = ln.scan(/\$\{?\w+\}?/)
        vars.map! { |x| x.gsub(/[${}]/,'') }
        vars.reject! { |x| x =~ /^\d$/}

        @variables = vars || []
        @variables.uniq!
      end

      # All variables used in shell script
      attr_accessor :variables

    end # ShellVariables
  end # Parser
end # Banalize
