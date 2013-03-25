module Banalize
  ##
  # Make ouput text indented and apply colors to it if this is required
  # 
  # @param [Hash] hash check result hash
  # @param [String] indent Default indent 4 spaces for each level
  #
  def self.beautify hash, indent='    '
    out = ''
    l1 = "\n"+indent
    l2 = "\n" << indent*2
    l3 = "\n" << indent*2 << "## "

    hash.each do |file,results|
      out << "\n\n#{file.color(:file)}"

      results.each do |f_or_s, checks|

        
        out << l1 << f_or_s << l1 << '-'*10

        checks.each do |policy, string|
          out << l1 << policy.to_s.color(f_or_s == 'Fail' ? :red : :yellow)
          if string
            lines = case string
                    when String
                      string.split("\n")
                    when Array
                      string
                    end
            lines.each do |line| 
              line.gsub!(/(line \d+:)(.*)/, '\1' +"#{l3}    "+ '\2' )
              out << l3 << line
            end

          end
        end
      end
      
    end
    out
  end
end
