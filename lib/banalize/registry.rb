module Banalize

  require 'active_support/inflector'
  require 'singleton'
  require 'debugger'
  ##
  # Class defining use of Banalize policies DSL. Sets some sane
  # default values.
  #
  class Registry

    ##
    # Default settings for policies
    #
    DEFAULT = { 
      policy: :bug,
      severity: 1,
      description: 'No description'
    }

    # Define new policy from loading Ruby file with policy.
    # 
    # ## Example
    #
    #         # First argument to the `describe` method call defines
    #         # policy name and description. So both `description` and
    #         # `policy_name` methods are optional in the block.
    #
    #         describe "Check that format of shebang is #!/usr/bin/env bash" do
    #        
    #           severity    5 # Default is 1
    #
    #           description "Can provide alternative description here"
    #           
    #           policy 'bug'
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
    # @param [String] myname description of the policy
    # @block [Block]
    def self.register  myname, &block

      klass  = myname.to_s.gsub(/\W/, '_').camelize

      c = Object.const_set klass, Class.new(self , &block)
      c.description myname
      c
    end

    ##
    # Creates new instance of policy check.
    #
    # @param [String] bash UNIX PATH to Bash script 
    #
    def initialize bash
      raise RuntimeError, "File does not exist: #{bash}" unless File.exists? bash
      @lines = File.readlines bash
      @bash = bash
    end
    
    ##
    # This method must be overwritten in children classes.
    def run
      raise ArgumentError, "You must override #run method in class ''#{self.class.policy_name}'"
    end

    attr_accessor :lines, :bash


    ##
    # Descripton of the policy. Description comes from the parameter
    # to self.define method, but can be overwwritten by calling
    # description methid in the block for define method.
    #
    def self.description desc=nil
      @description ||= desc.to_s.humanize
    end

    def self.help hlp=nil
      if hlp
        @help = hlp
      else
        @help ||= "No help available for #{self.name}"
      end
    end

    ##
    # Default policy is 'bug'
    #
    def self.policy p=DEFAULT[:policy]
      @policy ||= p
    end
    
    ##
    # Use lowest severity by default
    #
    def self.severity sev=DEFAULT[:severity]
      @severity ||= sev
    end

    ##
    # Name of this policy. 
    #
    # Note: `policy_name` corresponds to `name` in configuration of
    # non-ruby policies. Since `name` is method in ruby, use diffent
    # name, but `config` reports this with key `name`.
    def self.policy_name name=nil
      if name
        @name = name.to_sym
      else
        @name ||= self.name.underscore.to_sym
      end
    end

    ##
    # Same as config parameter of other binary checks: return
    # configuration.
    #
    def self.config
      { 
        name:        policy_name,
        policy:      policy,
        severity:    severity,
        description: description,
        klass:       name,
        help:        help
      }
    end
      


  end
end
