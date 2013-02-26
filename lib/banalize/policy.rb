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
      style: :core,
      severity: Severity.default,
      description: 'No description'
    }

    def initialize policy

      @config =
        Files.policies.find { |x| x[:policy] == policy.to_sym } ||
        raise(RuntimeError, "Policy ''#{policy}' not found among policy files")

    end

    attr_reader :config

    # Find policy or list of policies by search criteria.
    #
    # Search can be policy name (Symbol or String), Hash with
    # :policy and/or :severity keys or nil.
    #
    # - `nil` -  no filtering. Simply list of all policies returned.
    #
    # - `:severity` searched for policies with severity value same as
    #   search or higher.
    #
    # - `:style` - can be Symbol or Array of symbols. If it's :core
    #   or includes :core, all policies returned.
    #
    #
    # @param [String, Symbol, Hash] policy Name of a policy to check
    #     against or hash having :severity and/or :policy keys.
    #
    # @return [Hash]
    #
    def self.search search=nil
      case search

      when nil # If nothing given return all
        Files.policies

      when Symbol, String
        [Files.policies.find { |x| x[:policy] == search.to_sym }]

      when Hash
        res = Files.policies
        #
        if search.has_key? :style

          search[:style] = [search[:style]].flatten

          res = if search[:style].include?(:core)
                  res           # `core` - includes everything
                else
                  res.select { |x| search[:style].include? x[:style] }
                end
        end
        #
        # Find policies with severity this or higher
        #
        res = res.select { |x| x[:severity] >= search[:severity] } if
          search.has_key? :severity

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
