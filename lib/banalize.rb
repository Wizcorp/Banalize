$: << File.dirname(__FILE__)

require 'gli'
require 'mash'
require 'active_support/inflector'
require 'active_support/core_ext'

# Order is not important, load all of them
Dir.glob("#{File.dirname(__FILE__)}/{core_extensions,helpers}/*.rb").each do |r|
  require r
end

##
# This is shamelessly stolen form Rspec::DSL. Inject method `policy`
# into the top level namespace, so the we can use in policy definition
# without need to define class inheritance.
#
# Registerd policies are listed in `@@policies` array.
#
module Banalize
  ROOT      = File.dirname(File.dirname(__FILE__))
  VERSION   = File.read(ROOT+'/version.txt').chomp.strip

  # Local user directory with banalize config and policies
  
  dot_banalize = "#{Dir.home}/.banalize"

  USER = {
    dot_banalize: dot_banalize,
    config:       "#{dot_banalize}/config", # Default user config file
    styles:       "#{dot_banalize}/style",  # Default style file
    policies:     "#{dot_banalize}/policies"
  }

  # Truncate long error lines
  TRUNCATE  = ENV["BANALIZE_TRUNCATE_LINES"] == 'false' ? nil : 60

  module DSL
    @@policies = []
    def banalizer my_name, &block
      klass = Banalize::Registry.register(my_name, &block)
      @@policies  << klass
      klass
    end

    def policies
      @@policies
    end
  end
end

include Banalize::DSL

require 'banalize/parser/numbered'
require 'banalize/parser'
require 'banalize/exception'
require 'banalize/registry'

require 'banalize/errors'
require 'banalize/policy/severity'
require 'banalize/policy'
require 'banalize/files'
require 'banalize/runner'

