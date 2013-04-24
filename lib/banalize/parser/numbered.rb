module Banalize

  ##
  # Class numbered implements simple model of numbered lines data
  # structure. It's Mash (think Hash). 
  #
  # Each pair is { line_number => row }. Line numbers are *not*
  # necessarily sequential, i.e. line numbers in {Numbered} instance
  # corresponds to those of actuall analyzed script. 
  #
  # Base of numbers is 1. Examples:
  #
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ruby
  # p @shebang # { 1 => "#!/bin/bash" }
  #
  # p @code
  # # { 
  # #   2 => 'set -e',
  # #   3 => 'set -u'
  # # }
  #
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #
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
      line = search.keys.join ', '
      if Banalize::TRUNCATE
        line.truncate(
                      Banalize::TRUNCATE,
                      separator: ' ', 
                      omission: "... (total #{search.keys.length})" 
                      )
      end
    end
    
    alias :numbers :lines

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
    # Return all lines with numbers between from and to
    #
    # @param [Finxum] from Starting line
    # @param [Finxum] to   Ending line
    #
    # @return [Numbered] Instance of Numbered with all lines beween
    #     specified numbers. Numbers can be not sequntial.
    #
    def slice from, to
      from, to = from.to_i, to.to_i
      ret = self.class.new self.select { |k,v|  k.to_i.between?(from,to) }
    end

    ##
    # Sort by the order of lines numbers
    #
    # @return [Array] Sorted array of 2-elements arrays:
    #
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ruby
    # >> a.comments.sort {  |a,b| a.first.to_i <=> b.first.to_i }
    # => [["2", " Use perldoc functions to see documentation for this file."], 
    #    ["4", ":<<\"=cut\ 
    # ...
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #
    def sort
      self.sort { |a,b| a.first.to_i <=> b.first.to_i }
    end

    ##
    # Grep lines of the Numbered object (i.e. values of the hash) and
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
      @search = self.class.new(self.select { |idx,line|  line =~ pattern })
    end

    ##
    # Add new line to the collection of lines. 
    #
    # *Attention*: since {Numbered} is a hash, adding line with the
    # number that already exists will overwrite existing one.
    #
    # @param [String,Numbered] line Line or Numbered object to add
    #
    # @param [Finxum] number Line number in the analized script. If
    #     First param is {Numbered} instance, then this argument is
    #     not used.
    #
    # ## Example
    #
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ruby
    #     @shebang.add lines.shift if lines.first =~ /^#!/
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #
    def add line, number=0
      case line
      when String
        self[number.to_i] = line.chomp
      when Numbered
        self.merge! line
      end
    end

    ##
    # Delete numbered line by its number
    #
    # Delete line from {Numbered} and return it as
    #     single element {Numbered} object with line number.
    #
    # @param [Fixnum,Array[Fixnum],Numbered] lines Lines to delete from Numbered instance. 
    #
    # @return [Hash] Deleted lines as instance of {Numbered}
    #
    def delete lines
      ret = self.class.new

      case lines
      when Fixnum
        ret.add super(lines), lines
      when Array
        lines.each { |line| ret.add super(line), line }
      when Numbered
        ret.add self.delete lines.keys
      end

      ret
    end

  end
end
