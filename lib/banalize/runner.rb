# @markup markdown
module Banalize
  
  ##
  # Run policy check and return result of it.
  #
  # @param [String] bash Bash file for analisys
  #
  # @param [String, Hash] policy Name of a policy to check against or
  #     hash having :severity and/or :policy keys
  #
  # @see Policy.search
  #
  # @return [Array of Hashes] each element of array is { :name => result }
  #
  def self.check bash, search

    run_list = Policy.search search

    if run_list.empty?
      raise Banalize::Runner::Error, "No policy satisfying criteria: #{search.inspect}"     
    end

    run_list.map do |item|
      { item[:name] => Banalize::Runner.new(bash, item).result }
    end
  end

  ##
  # Executing policy checks against bash file(s). Class instance is
  # single bach file to check and single policy. Result of the check
  # is returned in `@result` instance variable (and attr_accessor).
  #
  # Instance attributes
  # ----------------------
  # - `@bash` - PATH to bash file
  #
  # - `@policy` - [Hash] Policy configuration hash, key :klass contains
  #           name of the class for Ruby policy. If Hash does not have
  #           :klass key, it's not a Ruby, execute it as shell policy.
  #
  # - `@result` - Currenty returns only Boolean (true - check OK/false
  #    check fail). This can change later.
  class Runner

    ##
    # Create new instance of policy check runner and execute
    # it. Result of the check is returned in @result attribute.
    #
    # @param [String] bash
    # @param [Hash] policy Policy configuration hash.
    #
    # @see Runner
    #
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
