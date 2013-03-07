module Banalize

  class Parser

    def initialize path
      @shebang = Numbered.new
      @comments = Numbered.new 
      @code = Numbered.new

      @shebang.add lines.shift if lines.first =~ /^#!/

      lines.each_index do |idx|
        if lines[idx] =~ /^\s*\#/
          @comments.add lines[idx], idx
        else
          @code.add lines[idx], idx
        end
      end
    end

    ##
    # Shebang contains first line of the script if it's in `#!`
    # format. Otherwise it is nil.
    attr_accessor :shebang

    ##
    # Contains all block comments of the file, including shebang line
    #
    # Only hash-comments are suported at this time. Comments in the
    # style of here-documents are not.
    attr_accessor :comments

    ##
    # Contains all non-comments of the script, excluding shebang line.
    #
    # Same as with comments, excluded from code blocks are only
    # hash-comments, but here-documents even if they are not executing
    # any action are included here.
    attr_accessor :code
  end
end
