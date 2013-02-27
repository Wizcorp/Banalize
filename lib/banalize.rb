$: << File.dirname(__FILE__)

require 'gli'
require 'mash'
require 'active_support/inflector'

require 'banalize/version'

require 'banalize/parser/numbered'
require 'banalize/parser'
require 'banalize/exception'
require 'banalize/registry'

require 'banalize/errors'
require 'banalize/policy/severity'
require 'banalize/policy'
require 'banalize/files'
require 'banalize/runner'

##
# This is shamelessly stolen form Rspec::DSL. Inject method `policy`
# into the top level namespace, so the we can use in policy definition
# without need to define class inheritance.
#
# Registerd policies are listed in `@@policies` array.
#
module Banalize
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
