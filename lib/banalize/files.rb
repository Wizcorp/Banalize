module Banalize

  require 'active_support/inflector'
  require 'singleton'

  ##
  # Class for handling policies files: reading and loading.
  #
  class Files


    include ::Singleton

    ##
    # Get list of all policy files installed in banalize.
    #
    #  Policies can come from Banalize distribution in
    #  `./lib/policies` directory or suppplied by user from
    #  `~/.banalize/policies` directory. This allows exteding Banalize
    #  by creating own policies without need to repackage gem.
    # 
    # @return [Hash] Sets class level variable `@@files` with list of
    #     policies. All policies are groupped in 3 arrays:
    #     `@@files[:all]`, `@@files[:ruby]`, `@@files[:other]`
    #
    def self.files
      all  = Dir.glob("#{File.dirname(File.dirname(__FILE__))}/policies/*")
      all += Dir.glob("#{Banalize::USER[:policies]}/*") if Dir.exists? Banalize::USER[:policies]

      all = all.grep(%r{/[^\.]})

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
      yaml = %x{ #{bash} config 2>&1 }
      abort "Can not execute policy file #{bash}: \n    ERROR #{yaml} " unless $?.exitstatus == 0
      hash = YAML.load(yaml) rescue  "Can not load YAML #{yaml}"

      abort "Loaded policy metdata is not Hash: #{hash.to_s}" unless hash.is_a? Hash
      hash.merge!({
                    path: bash,
                    policy: File.basename(bash).to_sym
                  })

      Policy::DEFAULT.merge Hash[hash.map { |k, v| [k.to_sym, v] }]
    end
  end
end
