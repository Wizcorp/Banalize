banalizer File.basename(__FILE__, '.rb').to_sym do

  synopsis 'All lines must be indented consistenly' 
  severity :brutal
  style    :cosmetic

  description <<EOF

When indenting the code all leading line indents should use the same
character: either all spaces or all tabs, but not mixed.

EOF


  def run
    ret = true

    has_tabs  = code.has?(/^\s*\t/)
    tab_lines = code.lines

    has_spcs  = code.has?(/^\s* /)
    spc_lines = code.lines

    if has_tabs && has_spcs
      errors.add "Code indented inconsistently: TABS and SPACES mixed"
      errors.add "    TAB indented: #{tab_lines}"
      errors.add "    SPC indented: #{spc_lines}"
      
    end
    
    return errors.empty?
  end

end
