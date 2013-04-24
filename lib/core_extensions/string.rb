##
# Extend class String with color codes
class String
  def color type
    return self unless $color
    color_code = case type
                 when :bold             then 1
                 when :white, :file     then 37
                 when :error, :red      then 31
                 when :green            then 32
                 when :policy, :yellow  then 33
                 end
    "\e[#{color_code}m#{self}\e[0m"
  end
end
