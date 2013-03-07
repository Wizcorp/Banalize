module Banalize

  ##
  # Run policy check and return result of it.
  #
  # @param [String] bash Bash file for analisys
  #
  # @param [String, Hash] search Name of a policy to check against or
  #     hash having :severity and/or :policy keys
  #
  # @see Policy.search
  #
  # @return [Array of Hashes] each element of array is { :name => result }
  #
  def self.run bash, search

    run_list = Policy.search search

    if run_list.empty?
      raise Banalize::Runner::Error, "No policy satisfying criteria: #{search.inspect}"
    end

    res = { }
    run_list.each do |policy|
      res[policy[:policy]] = Banalize::Runner.new(bash, policy).result
    end
    res
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
      object = policy[:klass].constantize.new(bash)
      res = object.run
      @result = {
        :status => res ? true : false,
        :messages => Errors.to_s(object.errors.messages)
      }
    end

    ##
    # Execute shell check
    #
    def shell
      err = %x{ #{policy[:path]} #{bash} }
      @result = {
        :status => ($?.exitstatus == 0),
        :messages => err
      }
    end

    # systemu is very slow
#     def shell_
#       stat, out, err = systemu  "#{policy[:path]} #{bash} "
#       @result = {
#         :status => ($?.exitstatus == 0),
#         :messages => err
#       }
#     end

  end
end
