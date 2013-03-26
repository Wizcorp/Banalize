banalizer :max_line_length do

  synopsis 'The line length must not exceed max number of characters' 
  severity :brutal
  style    :cosmetic

  default  :max => 88 # Default can be overwritten by personal styles
                      # file
 
  description <<EOF

Bash Style Guide and Coding Standard
====================================

1 Length of line

The total length of a line (including comment) must not exceed more
than 88 characters. Thus searching in cross direction can be avoided
and the file can be printed with the usual width of paper without
lines being cut or line breaks. Instructions have to be split up, as
applicable, texts can be made up as well.  

Ref.: http://lug.fh-swf.de/vim/vim-bash/StyleGuideShell.en.pdf

EOF


  def run
    ret = true

    offset = shebang ? 2 : 1 # Offset for line numbers, 

    lines.each_index do |idx|
      len = lines[idx].length
      errors.add(
                 "Line # #{idx + offset} is #{len} characters long, expected to be #{default[:max]} char. max."
                 ) if len > default[:max]
    end
    
    return errors.empty?
  end

end
