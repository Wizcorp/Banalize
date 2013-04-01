banalizer File.basename(__FILE__, '.rb').to_sym do

  synopsis 'Script file should be commented. Check percentage of code vs commetns' 
  severity :brutal
  style    :cosmetic

  # What the minumum percentage of comments, by number of lines should
  # be in your code
  default percent: 30

  def run

    if code.size == 0
      errors.add "Code size is 0"

    else
      pct = ((comments.size.to_f / code.size) * 100).to_i
      errors.add "Code comment coverage #{pct}%" if pct < default[:percent]
    end

    errors.empty?
  end

end
