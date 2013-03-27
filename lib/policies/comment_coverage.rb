banalizer File.basename(__FILE__, '.rb').to_sym do

  synopsis 'Script file should be commented. Check percentage of code vs commetns' 
  severity :brutal
  style    :cosmetic

  # What the minumum percentage of comments, by number of lines should
  # be in your code
  default percent: 30

  def run
    pct = ((comments.size.to_f / code.size) * 100).to_i

    errors.add "Code commented on #{pct}%" if pct < default[:percent]
    errors.empty?
  end

end
