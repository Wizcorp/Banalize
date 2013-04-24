banalizer :explicitly_define_path_variable do
  
  style :security
  severity :gentle

  description <<-EOF

PATH varaible  should be defined  explicitly in the script.  It should
*only* list absolute path names and does not have $PATH variable.

Ref.: http://hub.opensolaris.org/bin/view/Community+Group+on/shellstyle#HPathnames

It  is always  a good  idea  to be  careful about  $PATH settings  and
pathnames  when writing shell  scripts. This  allows them  to function
correctly even  when the  user invoking your  script has  some strange
$PATH set in their environment.

 There are two acceptable ways to do this:

 (1) make *all* command references in your script use explicit pathnames:

/usr/bin/chown root bar
/usr/bin/chgrp sys bar
 or (2) explicitly reset $PATH in your script:

PATH=/usr/bin; export PATH

chown root bar
chgrp sys bar

DO NOT  use a  mixture of  (1) and (2)  in the  same script.  Pick one
method and use it consistently.

EOF

  parser :bash

  def run
    if code.dont_have?(/^\s*PATH=/)
      errors.add "PATH variable is not defined in the script"
    end

    if code.has?(/PATH=.*\$\{?PATH\}?/)
      errors.add "PATH variable defined by extending existing $PATH variable at: #{code.lines}"
      errors.add "    #{code.search.inspect}"
      errors.add code
    end

    return errors.empty?
  end
  
end
