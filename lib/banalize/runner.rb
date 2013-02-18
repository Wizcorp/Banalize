module Banalize
  
  ##
  # @param [String] bash Bash file for analisys
  # @param [String] policy Name of a policy to check against
  #
  def self.check bash, policy
    if pol = Files.policies.find { |x| x[:name] == policy }
      Banalize::Runner.new bash, pol
    else
      raise Banalize::RunnerError, "Policy not found: #{policy}" 
    end
  end

  class Runner

    def initialize bash,policy
      @bash, @policy = bash, policy

      if @policy.has_key? :klass
        ruby
      else 
        shell
      end
    end

    attr_accessor :policy, :bash

    def ruby
      policy[:klass].constantize.new(file).run 
    end
    
    def shell
      %x{ #{policy[:path]} #{bash} }
      print $?
    end
  end



end
