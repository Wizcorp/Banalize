module Banalize
  class Parser

    def initialize path
      @shebang = nil
      @comments = @code = { }

      @shebang = lines.shift.chomp if lines.first =~ /^#!/
      lines.each_index do |idx|
        if lines[idx] =~ /^\s*\#/
          @comments[idx] = lines[idx].chomp
        else
          @code[idx] = lines[idx].chomp
        end
      end
    end

    # TODO
    def has
    end
    
    
    # TODO
    def grep
    end

    attr_accessor :shebang, :comments, :code
  end
end
