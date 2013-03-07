
![banalize](images/banalize_small.png)

Parser architecture
===========

Class Parser
-----------

Bash basic parser defines following methods:

- {Banalize::Parser#shebang} - first line of the script if it's in `#!` format or nil
- {Banalize::Parser#comments} - all block comments of the file, including shebang line
- {Banalize::Parser.code} - all non-comments of the script, excluding shebang line


All data returned by parser methods are instances of {Banalize::Numbered} class, i.e. they are lines of code with corresponing line number in the script file.

Class Numbered
----------------------

Class {Banalize::Numbered} provides some helper methods to make searches simpler in the script files:

- {Banalize::Numbered#grep}

  Find and return lines matching regular expresion.

- {Banalize::Numbered#has?}  Aliased to {Banalize::Numbered#have?}.

  Search for pattern in all lines, return true or false
  
- {Banalize::Numbered#does\_not\_have?} Alias {Banalize::Numbered#dont_have?}
  
  Opposite for the above method. Return true if pattern in not found.

- {Banalize::Numbered#search} - attribute accessor. It always contains result of the last grep search.
- {Banalize::Numbered#lines} 
- {Banalize::Numbered#to_s} (alias: {Banalize::Numbered#inspect})

Additional parsers
===========

Will be added in the future.
