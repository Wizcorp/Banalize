$: << File.dirname(__FILE__)

require 'gli'
require 'active_support/inflector'
require 'systemu'


require 'banalize/version'
require 'banalize/exception'
require 'banalize/policy'
require 'banalize/files'
require 'banalize/runner'

module Banalize
  module DSL
    @@policies = []
    def policy my_name, &block
      klass = Banalize::Policy.define(my_name, &block)
      @@policies  << klass
      klass
    end

    def policies
      @@policies
    end
  end
end

include Banalize::DSL
