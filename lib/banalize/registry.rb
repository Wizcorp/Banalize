module Banalize

  require 'active_support/inflector'
  require 'singleton'
  ##
  # Class defining use of Banalize policies DSL. Sets some sane
  # default values for each of the DSL methods and registers new
  # policy in the list of policies.
  #
  # Instance attributes
  # -----------
  # - {#errors}
  # - {#default}
  #
  # Other attributes are inherited from parent Parser class.
  #
  # Class methods
  # ----------------------
  # Class methods define DSL for Banalizer. These are:
  #
  # - {register}
  # - {policy}
  # - {synopsis}
  # - {description}
  # - {default}
  # - {style}
  # - {config}
  class Registry < Parser

    # Define new policy from loading Ruby file with policy.
    #
    # ## Example
    #
    #         # First argument to the `banalizer` method call defines
    #         # policy name and short description (AKA synopsis).
    #         # Both `description` and `policy_name` methods are
    #         # optional in the block.
    #
    #         banalizer "Check that format of shebang is #!/usr/bin/env bash" do
    #
    #           severity    5 # Default is 1
    #
    #           synopsis "Can provide alternative description here"
    #
    #           style 'bug'
    #
    #           policy_name "Don't need to specify policy name,it is defined from argument to `describe` method"
    #
    #           # All method calls are optional. Only required things
    #           # are policy description and definition of method
    #           # `run`. Method `run` must be overwritten, otherwise
    #           # it simply raises execption.
    #           #
    #           # Run method must return something that evaluates into
    #           # `true` (policy check successful) or `false`.
    #           #
    #           def run
    #             lines.first =~ %r{^\#!/usr/bin/env\s+bash}
    #           end
    #         end
    #
    # @param [String] myname name for the policy
    # @param [Block] block
    def self.register  myname, &block

      klass  = myname.to_s.gsub(/\W/, '_').camelize

      c = Object.const_set klass, Class.new(self , &block)

      c.synopsis myname
      c.default({})
      c.severity Policy::DEFAULT[:severity] unless c.severity # Set default severity if it's not defined in block

      # Override these with Styles file
      begin
        c.description $styles[myname][:description] 
        c.severity    $styles[myname][:severity]
      rescue NoMethodError => e
      end
      
      return c
    end

    # TODO: how to load parsers ????

    @@parsers = []
    def self.parser name
      @@parsers << name
    end

    ##
    # Creates new instance of policy check.
    #
    # @param [String] bash UNIX PATH to Bash script
    #
    def initialize bash
      raise RuntimeError, "File does not exist: #{bash}" unless File.exists? bash

      @path = bash
      @errors = Errors.new self

      # Make class level default variable accessible as instance level
      # variable and accessor

      super @path
      @default = self.class.default.merge( $styles[self.class.config[:policy]] || {} )

    end

    ##
    # Instance level accessor for the defaults 
    #
    # Instance defaults hold same data as in class level default
    # method. Instance level data are merged on initializing with
    # personal styles data.
    attr_accessor :default

    # Instance of Errors class to hold all error messages from tests
    attr_accessor :errors

    ##
    # This method must be overwritten in children classes.
    def run
      raise ArgumentError, "You must override #run method in class ''#{self.class.policy_name}'"
    end


    ##
    # Name of this policy.
    #
    def self.policy name=nil
      if name
        @policy = name.to_sym
      else
        @policy ||= self.name.underscore.to_sym
      end
    end

    ##
    # Set defaults for the policy. Defaults are hash with values used
    # in {#run} method. When defining defaults, define them as:
    #
    # ```
    #   default :max => 20
    # ```
    #
    # During run defaults accessible as default[:max]
    #
    # Defaults can be overwriten by personal style configuration file. See {file:CONFIGURATION.md} for details.
    #
    def self.default hash=nil
      @default ||= hash 
    end


    ##
    # Short summary of the policy. Synopsis comes from the name of the
    # policy which is first parameter to the `banalizer` method, but
    # can be overwwritten by calling systemu DSL method in the block
    # for the `banalizer` method.
    #
    def self.synopsis desc=nil
      @synopsis ||= desc.to_s.humanize
    end

    def self.description hlp=nil
      if hlp
        @description = hlp
      else
        @description ||= "No description available for #{self.name}"
      end
    end

    ##
    # Default style is 'bug'
    #
    def self.style p=Policy::DEFAULT[:style]
      @style ||= p
    end

    ##
    # Use lowest severity by default
    #
    def self.severity sev=nil
      if sev
        @severity = Banalize::Policy::Severity.to_i(sev)
      else
        @severity ||= Banalize::Policy::Severity.to_i(sev)
      end
    end


    ##
    # 
    # Return configuration for the policy.
    #
    # Same as config parameter of 'other' checks.
    #
    # @return [Hash] Hash containing all configured attributes of the
    #     policy check.
    #
    def self.config
      {
        policy:      policy,
        synopsis:    synopsis,
        style:       style,
        severity:    severity,
        description: description,
        klass:       name,
        default:     default
      }
    end



  end
end
