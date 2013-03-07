module Banalize

  ##
  # Class numbered implements simple model of numbered lines data
  # structure. It's Mash (think Hash). 
  #
  # Each pair is line_number => row. Line numbers are *not*
  # necessarily sequential.
  class Numbered < ::Mash

    def initialize *p
      @search = nil
      super *p
    end

    ##
    # Return true if values of instance have specifid pattern,
    # returned by {#grep}.
    #
    # @see #grep
    #
    def has? *params
      !grep(*params).empty?
    end
    alias :have? :has?
    
    ##
    # Opposite of {#has?}
    # @see #has?
    def does_not_have? *p
      ! has? *p
    end
    alias :dont_have? :does_not_have?


    ##
    # Helper method to display only line numbers of the search result.
    #
    # Comma separated string with line numbers of {#search}
    #
    def lines
      search.keys.join ', '
    end

    ##
    # Search attribute always contains last result of search (grep)
    # operation.
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
    # Grep lines of the Numbered object (i.e. velues of the hash) and
    # return all lines together with numbers that match
    #
    # @param [Regexp] pattern Search Regexp pattern for lines. It
    #     should be regexp, not string, since regular Array grep is
    #     not used here.
    #
    # @return [Numbered] Returns new instance of the same class
    #     {Numbered} containing only lines matching the search.
    #
    def grep pattern
      @search = self.select { |idx,line|  line =~ pattern }
      self.class.new(@search)
    end

    ##
    # Add new line to the collection of lines. 
    #
    # *Attention*: since {Numbered} is a hash, adding line with the
    # number that already exists will overwrite existing one.
    #
    # ## Example
    #
    # ```
    #       @shebang.add lines.shift if lines.first =~ /^#!/
    # ```
    def add line, number=0
      self[number] = line.chomp
    end

  end
end
