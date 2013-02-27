module Banalize

  require 'active_support/inflector'
  require 'singleton'
  require 'debugger'
  ##
  # Class defining use of Banalize policies DSL. Sets some sane
  # default values for each of the DSL methods and registers new
  # policy in the list of policies.
  #
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
    # @block [Block]
    def self.register  myname, &block

      klass  = myname.to_s.gsub(/\W/, '_').camelize

      c = Object.const_set klass, Class.new(self , &block)
      c.synopsis myname
      c
    end

    ##
    # Creates new instance of policy check.
    #
    # @param [String] bash UNIX PATH to Bash script
    #
    def initialize path
      raise RuntimeError, "File does not exist: #{path}" unless File.exists? path
      @lines = File.readlines path
      @path = path
      @errors = Errors.new self
      super path
    end

    attr_accessor :errors

    ##
    # This method must be overwritten in children classes.
    def run
      raise ArgumentError, "You must override #run method in class ''#{self.class.policy_name}'"
    end

    attr_accessor :lines, :path

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
    def self.severity sev=Policy::DEFAULT[:severity]
      @severity ||= Banalize::Policy::Severity.to_i(sev)
    end


    ##
    # Same as config parameter of other binary checks: return
    # configuration.
    #
    def self.config
      {
        policy:      policy,
        synopsis:    synopsis,
        style:       style,
        severity:    severity,
        description: description,
        klass:       name
      }
    end



  end
end