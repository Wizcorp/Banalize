# @title List of available policies

# Banalizer

![banalize](images/banalize_small.png)


## Braces For Variables

*Always use braces to isolate variables ${a}*

* Policy name: braces_for_variables
* Severity:    4
* Style:       bugs
* Defaults:    N/A

**Description**

````

Use braces around variables
---------------------------

To prevent wrong expansion of variables always use braces around
variables. I.e.

Good: ${VARIABLE}
Bad:  $VARIABLE

foo=sun
echo $fooshine     # $fooshine is undefined
echo ${foo}shine   # displays the word "sunshine"



````

------------------------------------------------------------------


## Comment Coverage

*Script file should be commented. check percentage of code vs commetns*

* Policy name: comment_coverage
* Severity:    1
* Style:       cosmetic
* Defaults:    
  * percent: 30


**Description**

````
No description available for CommentCoverage

````

------------------------------------------------------------------


## Consistent Indents

*All lines must be indented consistenly*

* Policy name: consistent_indents
* Severity:    3
* Style:       cosmetic
* Defaults:    N/A

**Description**

````

When indenting the code all leading line indents should use the same
character: either all spaces or all tabs, but not mixed.



````

------------------------------------------------------------------


## Exit On Error

*Script should be run with -e option or `set -o errexit`*

* Policy name: exit_on_error
* Severity:    5
* Style:       core
* Defaults:    N/A

**Description**

````
Using this option forces bash script to exit on first error.
  
man bash:

         -e      Exit immediately if a simple command (see SHELL GRAMMAR above)
                 exits with a non-zero status.  The shell does not exit if  the
                 command  that  fails  is  part of the command list immediately
                 following a while or until keyword, part of the test in an  if
                 statement, part of a && or || list, or if the command's return
                 value is being inverted via !.  A trap on ERR, if set, is exe-
                 cuted before the shell exits.


`set -o errexit` is the same as `set -e`.



````

------------------------------------------------------------------


## Explicitly Define Path Variable

*Explicitly define path variable*

* Policy name: explicitly_define_path_variable
* Severity:    5
* Style:       security
* Defaults:    N/A

**Description**

````

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



````

------------------------------------------------------------------


## Indentation Style

*All lines must be indented accordingly to defined style*

* Policy name: indentation_style
* Severity:    3
* Style:       cosmetic
* Defaults:    
  * style: spaces


**Description**

````

When indenting the code, all  leading line indents should use the same
character: either all SPACES or all TABS, specified by the indentation
style.

Indenation style can be set in personal style file. Set it to :tabs or
:spaces. See CONFIGURATION.md for details.



````

------------------------------------------------------------------


## Max Line Length

*The line length must not exceed max number of characters*

* Policy name: max_line_length
* Severity:    1
* Style:       cosmetic
* Defaults:    
  * max: 88


**Description**

````

Github code browser screen width
=================================

Max line width: 105 chars.

Github pull request and online code viewer is about 108 characters
wide.  To be able to browse  code on github without need to scroll
left-right,  limit line  length to  105 characters,  to accomodate
some extra characters Git adds for diffs (`+ `).


````

------------------------------------------------------------------


## Minus N Syntax Check

*Bash syntax check*

* Policy name: minus_n_syntax_check
* Severity:    5
* Style:       core
* Defaults:    N/A

**Description**

````
This policy runs syntax check using 'bash -n' option.


````

------------------------------------------------------------------


## Shebang Format

*Shebang format*

* Policy name: shebang_format
* Severity:    5
* Style:       core
* Defaults:    N/A

**Description**

````
Format of shebang should be #!/usr/bin/env bash

````

------------------------------------------------------------------


## Should Use Set Nounset

*Always use 'set -u' or 'set -o nounset' in scripts*

* Policy name: should_use_set_nounset
* Severity:    5
* Style:       bug
* Defaults:    N/A

**Description**

````

Quote from: http://www.davidpashley.com/articles/writing-robust-shell-scripts.html

Use set -u
===========

    How often have you written a script that broke because a variable
    wasn't set? I know I have, many times.

chroot=$1
...
rm -rf $chroot/usr/share/doc 

    If you ran the script above and accidentally forgot to give a
    parameter, you would have just deleted all of your system
    documentation rather than making a smaller chroot. So what can you
    do about it? Fortunately bash provides you with set -u, which will
    exit your script if you try to use an uninitialised variable. You
    can also use the slightly more readable set -o nounset.

% bash /tmp/shrink-chroot.sh
$chroot=
david% bash -u /tmp/shrink-chroot.sh
/tmp/shrink-chroot.sh: line 3: $1: unbound variable
david% 



````

------------------------------------------------------------------


## Trailing Spaces

*Code lines should not have spaces or tabs at the end*

* Policy name: trailing_spaces
* Severity:    1
* Style:       cosmetic
* Defaults:    N/A

**Description**

````
No description available for TrailingSpaces

````

------------------------------------------------------------------


## Uninitialized Variables

*Variables should be explicitly initialized*

* Policy name: uninitialized_variables
* Severity:    5
* Style:       security
* Defaults:    N/A

**Description**

````

Variable initialization
------------------------

As in C, it's always a good idea to initialize your variables, though,
the  shell  will  initialize  fresh variables  itself  (better:  Unset
variables   will  generally   behave  like   variables   containing  a
nullstring).

It's  no problem  to pass  a variable  you use  as environment  to the
script. If you blindly assume that all variables you use are empty for
the first time, somebody can inject a variable content by just passing
it in the environment.

The solution is simple and effective: Initialize them

my_input=""
my_array=()
my_number=0

If you do that  for every variable you use, then you  also have a kind
of documentation for them.

Ref: http://wiki.bash-hackers.org/scripting/style#variable_initialization



````

------------------------------------------------------------------

