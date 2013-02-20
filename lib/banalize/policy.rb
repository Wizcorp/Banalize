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

    # Find policy or list of policies by searsh criteria. Search can
    # be policy name (Symbol or String) or Hash with :policy and/or
    # :severity keys.
    #
    # @param [String, Symbol, Hash] policy Name of a policy to check
    #     against or hash having :severity and/or :policy keys
    #
    # @return [Hash] 
    #
    def self.search search 
      case search
        
      when Symbol, String
        [ Files.policies.find { |x| x[:name] == search.to_sym } ]
        
      when Hash
        res = Files.policies
        [:policy, :severity].each do |key|
          res = res.select{ |x| x[key] == search[key] } if search.has_key? key
        end
        res

      else
        raise ArgumentError, "Unknown search criteria: #{search.inspect}"

      end.compact
    end

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
