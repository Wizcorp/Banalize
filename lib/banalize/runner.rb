module Banalize
  
  ##
  # Run policy check and return result of it.
  #
  # @param [String] bash Bash file for analisys
  # @param [String, Hash] policy Name of a policy to check against
  #
  def self.check bash, search
    run_list = case search
               when String
                 [ Files.policies.find { |x| x[:name] == search } ]
               when Hash
                 res = Files.policies
                 [:policy, :severity].each do |key|
                    res = res.select{ |x| x[key] == search[key] } if search.has_key? key
                  end
                 res
               else
                 raise Banalize::Runner::ArgumentError, "Unknown search criteria: #{search.inspect}"
               end
    
    if run_list.empty?
      raise Banalize::Runner::Error, "No policy satisfying criteria: #{search.inspect}"     
    end

    run_list.map do |item|
      { item[:name] => Banalize::Runner.new(bash, item).result }
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
