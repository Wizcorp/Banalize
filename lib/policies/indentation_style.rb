banalizer File.basename(__FILE__, '.rb').to_sym do

  synopsis 'All lines must be indented accordingly to defined style' 
  severity :harsh
  style    :cosmetic

  # Can be either :tabs or :spaces. Can overwrite in custom style file.
  default :style => :spaces

  description <<EOF

When indenting the code, all  leading line indents should use the same
character: either all SPACES or all TABS, specified by the indentation
style.

Indenation style can be set in personal style file. Set it to :tabs or
:spaces. See CONFIGURATION.md for details.

EOF


  def run

    rex = case default[:style]
          when :tabs
            %r{^\s* }
          when :spaces
            %r{^\s*\t}
          end
    
    if code.has? rex
      errors.add "Impoperly indented code. Current style is #{default[:style].to_s.upcase}"
      errors.add "    Badly indented lines: #{code.lines}"
    end
            
    
    return errors.empty?
  end

end
