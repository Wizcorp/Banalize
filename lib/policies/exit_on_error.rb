banalizer :exit_on_error do

  synopsis 'Script should be run with -e option or `set -o errexit`'
  
  description <<EOF
Using this option forces bash script to exit on first error.
  
MAN BASH:

         -e      Exit immediately if a simple command (see SHELL GRAMMAR above)
                 exits with a non-zero status.  The shell does not exit if  the
                 command  that  fails  is  part of the command list immediately
                 following a while or until keyword, part of the test in an  if
                 statement, part of a && or || list, or if the command's return
                 value is being inverted via !.  A trap on ERR, if set, is exe-
                 cuted before the shell exits.


`set -o errexit` is the same as `set -e`.

EOF

  severity :gentle

  def run
    ret = true
    #
    # Prohibit using set +e option
    #
    errors.add "Setting +e option in shebang: #{shebang}" if (shebang.has? /\+e/)
    if code.has? /set\s+\+e/
      errors.add "Use of +e to unset -e option prohibited"
      errors.add "Bad lines are: #{code.search.keys}"
    end

#     if lines.first =~ %r{^\#!} && lines.first =~ /\s*+e/
#       errors.add "Using option +e to unset -e option"
#       ret &&= false
#     end
      
#     end
    
    
#     unless lines.grep(/^[^\#]*set\s+\-e/) && lines.grep(/^[^\#]*set\s+\-o\s+errexit/) && lines.first =~ /\s*-e/
#       errors.add "Didn't see set -e option nowhere in script"
#       ret &&= false
#     end

    return errors.empty?
  end

end
