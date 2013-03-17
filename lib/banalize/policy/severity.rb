module Banalize
  class Policy
    class Severity

      LIST = { gentle: 5, stern: 4, harsh: 3, cruel: 2, brutal: 1 }

      def initialize severity
        @severity = self.to_i severity
      end

      def self.default
        :gentle
      end

      def self.to_i severity
        case severity
        when Symbol, String
          LIST[severity.to_sym]
        when Fixnum
          severity
        end
      end
      ##
      # Describe available severities in a taxt format
      #
      def self.to_s
        format  = "%-20s%s"
        LIST.map do |k,v|
          sprintf format , k.to_s.humanize, v
        end.join "\n"
        
      end
    end #severity
  end
end
