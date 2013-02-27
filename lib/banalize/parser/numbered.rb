module Banalize
  class Numbered < ::Mash

    ##
    # Return true if values of instance have specifid pattern,
    # returned by gerp.
    #
    def has? *params
      !grep(*params).empty?
    end
    

    def initialize *p
      @search = nil
      super *p
    end

    ##
    # Comma separater string with line numbers of @search
    #
    def lines
      search.keys.join ', '
    end

    ##
    # Should always contain last result of search operation: grep etc.
    #
    attr_accessor :search

    ##
    # Human readable form. Only lines without numbers.
    #
    def to_s
      if self.count == 1 
        self.values.first.to_s
      else
        self.values.to_s
      end
    end
    
    alias :inspect :to_s
    
    ##
    # Grep only values and return all lines with numbers that match
    #
    def grep pattern
      @search = self.select { |idx,line|  line =~ pattern }
      self.class.new(@search)
    end

    def add line, number=0
      self[number] = line.chomp
    end

  end
end
