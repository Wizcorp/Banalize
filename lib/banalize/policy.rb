module Banalize

  require 'active_support'

  ##
  # Class defining use of Banalize policies DSL
  class Policy

    def description
    end

    def policy
    end

    def severity
    end

    def name
      self.class.name.to_s
    end


  end
end
