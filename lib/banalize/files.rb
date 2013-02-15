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
    def files
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
    def policies
      policies = []
      files[:other].each do |f|
        policies << YAML.load(%x{ #{f} config })
      end
      
      files[:ruby].each do |f|
        require f
        policies << File.basename(f, ".rb").camelize.constantize.config
      end
      policies
    end

# GET config
# File.basename(Banalize::Policy.files[:ruby].first, ".rb").camelize.constantize
# 
  end
end
