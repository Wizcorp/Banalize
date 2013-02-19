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
      ruby = all.dup.keep_if { |x| x=~ /\.rb$/}

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
      
      @policies ||= (files[:other].map { |f| 
                       YAML.load(%x{ #{f} config }).merge({ path: f,
                                                            name: File.basename(f)
                                                          })
                     }) + 
        Banalize.policies.map(&:config)
        
        
        #File.basename(f, ".rb").camelize.constantize.config

    end

  end
end
