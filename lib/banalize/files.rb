module Banalize

  require 'active_support/inflector'
  require 'singleton'

  ##
  # Class for handling policies files
  #
  class Files


    include ::Singleton

    ##
    # Get list of all policy files installed in banalize.
    #
    def self.files
      all  = Dir.glob("#{File.dirname(File.dirname(__FILE__))}/policies/*")
      ruby = all.dup.keep_if { |x| x=~ /\.rb$/ }

      @@files ||= {
        all:    all,
        ruby:   ruby,
        other:  (all - ruby)
      }
    end

    ##
    # Load and populate policies list with configuration of each
    # policy.
    #
    # For Ruby policies it requries each file and then calls #config
    # method for it.
    def self.policies

      files[:ruby].each { |f| require f }

      @policies ||= (files[:other].map { |f| shell_config f }) +
                     Banalize.policies.map(&:config)
    end

    ##
    # Read configuration from Bash shell policy and return it as Hash
    #
    # @param [String] bash PATH to bash policy file
    #
    def self.shell_config bash
      hash = YAML.load(%x{ #{bash} config }).merge({
                                                      path: bash,
                                                      name: File.basename(bash).to_sym
                                                    })

      Policy::DEFAULT.merge Hash[hash.map { |k, v| [k.to_sym, v] }]
    end
  end
end
