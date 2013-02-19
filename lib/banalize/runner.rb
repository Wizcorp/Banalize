module Banalize
  
  ##
  # Run policy check and return result of it.
  #
  # @param [String] bash Bash file for analisys
  # @param [String] policy Name of a policy to check against
  #
  def self.check bash, policy
    if pol = Files.policies.find { |x| x[:name] == policy }
      Banalize::Runner.new(bash, pol).result
    else
      raise Banalize::Runner::Error, "Policy not found: #{policy}" 
    end
  end

  
  class Runner

    ##
    # Create new instance of policy check runner and execute
    # it. Result of the check is returned in @result attribute.
    #
    # @param [String] bash
    #
    # @param [Hash] policy Policy configuration hash, key :klass
    #     contains name of the class for Ruby policy. If Hash does not
    #     have :klass key, it's not a Ruby, execute it as shell
    #     policy.

    def initialize bash,policy
      @bash, @policy, @result = bash, policy, nil

      if @policy.has_key? :klass
        ruby
      else 
        shell
      end
    end

    attr_accessor :policy, :bash, :result
    
    ##
    # Execute ruby check
    #
    def ruby
      @result = policy[:klass].constantize.new(bash).run ? true : false
    end
    
    ##
    # Execute shell check
    #
    def shell
      %x{ #{policy[:path]} #{bash} }
      @result = ($?.exitstatus == 0)
    end
  end



end
