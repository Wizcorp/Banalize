module Banalize
  class Parser

    ##
    # Munin project uses documentation in the style of Perl's
    # POD. These comments are not detected by standard Bash
    # parser. This mixin takes POD style comments from {#code} and put
    # them in {#comments}
    #
    # POD style comments are in the form:
    #
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~bash
    # :<<"=cut"
    # 
    # =head1 NAME
    #  ....
    #  ...
    #
    # =cut
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    module PodStyleComments
      
      ##
      # Parse bash here-doc comments in the POD style and move them to
      # {#comments}
      #
      #
      def pod_comments
        start = code.grep(/^:<<"?=cut"?\s*$/)
        cut   = code.grep(/^=cut\s*$/)
        
        raise "Started not the same number of POD blocks as ended: #{start.size} vs #{cut.size}" if
          start.size != cut.size
        
        start.each do |start_pod|

          start_pod = start_pod.first.to_i
          cut_pod   = cut.shift.first.to_i

          raise "Starting line of POD comment after ending line: #{start_pod} > #{cut_pod}" if 
            start_pod > cut_pod
          
          comments.add code.delete(code.slice(start_pod,cut_pod))
        end
      end

    end # PodStyleComments
  end # Parser
end # Banalize
