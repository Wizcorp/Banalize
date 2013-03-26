banalizer File.basename(__FILE__, '.rb').to_sym do

  synopsis 'Code lines should not have spaces or tabs at the end' 
  severity :harsh
  style    :cosmetic

  def run

    if code.has?(/\s$/)
      errors.add "Trailing spaces at the end of lines: #{code.lines}"
    end
    
    return errors.empty?
  end

end
