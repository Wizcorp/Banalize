module Banalize
  ##
  # Class defining use of Banalize policies. Mainly for accessing
  # attributes created by Banalize::Files class methods.
  #
  class Policy

    ##
    # Default settings for policies
    #
    DEFAULT = { 
      policy: :bug,
      severity: 1,
      description: 'No description'
    }

    def initialize policy

      @config = 
        Files.policies.find { |x| x[:name] == policy.to_sym } ||
        raise(RuntimeError, "Policy ''#{policy}' not found")

    end

    attr_reader :config

    ##
    # Return values of config hash
    #
    def method_missing symbol, *args, &block
      return config[symbol] if config.has_key? symbol
      super symbol, *args, &block
    end

    def self.method_missing symbol, *args, &block
      self.new(*args).send symbol
    end

  end
end
