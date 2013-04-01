module Banalize
  
  require_relative 'parser/pod_comments'
  require_relative 'parser/variables'

  # Instance attributes
  # -----------
  # Class sets following attribute accessor methods:
  #
  # - {#lines}
  # - {#path} 
  # - {#shebang}
  # - {#comments}
  # - {#code}
  
  class Parser
    
    include PodStyleComments
    include ShellVariables
    
    def initialize path
      @lines     = IO.read(path).force_encoding("utf-8").split($/)
      @shebang   = Numbered.new
      @comments  = Numbered.new 
      @code      = Numbered.new
      @variables = []
      
      @shebang.add @lines.shift if @lines.first =~ /^#!/

      @lines.each_index do |idx|

        next if @lines[idx] =~ /^\s*$/

        lineno = idx + 1 + (@shebang ? 1 : 0) # Compensate for base-0 and shebang line

        if @lines[idx] =~ /^\s*\#/
          @comments.add @lines[idx], lineno
        else
          @code.add @lines[idx], lineno
        end
      end
      pod_comments
      shell_variables
    end

    # Lines of the tested bash file, split by \n's
    attr_accessor :lines

    # UNIX path to the tested file
    attr_accessor :path


    ##
    # Shebang contains first line of the script if it's in `#!`
    # format. Otherwise it is nil.
    attr_accessor :shebang

    ##
    # Contains all block comments of the file, excluding shebang line
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
