module Banalize

  require 'active_support/inflector'
  require 'singleton'
  ##
  # Class defining use of Banalize policies DSL. Sets some sane
  # default values.
  #
  class Policy


    def initialize bash
      raise RuntimeError, "File does not exist: #{bash}" unless File.exists? bash
      @lines = File.readlines bash
      @bash = bash
    end

    def run
      raise ArgumentError, "You must override #run method"
    end

    attr_accessor :lines, :bash

###
###  Sandboxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
###

    ##
    # Descripton of the policy. If no description is provided then set
    # default.
    def self.description desc=nil
      if desc
        @description = desc
      else
        @description ||= "No description for #{self.name}"
      end
    end

    ##
    # Default policy is 'bug'
    #
    def self.policy p='bug'
      @policy ||= p
    end
    
    ##
    # Use lowest severity by default
    #
    def self.severity sev=1
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
        @name = name 
      else
        @name ||= self.name.underscore
      end
    end

    ##
    # Same as config parameter of other buinary checks: return
    # configuration.
    #
    def self.config
      { 
        name:        policy_name,
        policy:      policy,
        severity:    severity,
        description: description,
        klass:       name
      }
    end
      


  end
end
