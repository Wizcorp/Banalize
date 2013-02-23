
Name
===========

Banalize - static code analyzer for Bash

Description
===========

Banalizer is syntax analyzer for bash scripts. It is modelled after ideas of `Perl::Critic` project - analyzer for Perl scripts. Most of the Banalizer is written in Ruby. Exception is policy files which are language agnostic, and can be written in any language: scripting or compiled.

Banalizer consists of main binary file, banalyzer libraries, command line interface (CLI) and policies. 

Policy is requirement for bash script/file. For example: each script must have 'shebang' as first line.

Each policy is implemented as Ruby or other programming/scripting language file able to perform single check on single bash script file. Rest - aggregating checks, reporting, filtering etc - is handled by Banalizer.

### Severity

### Policy group

Conventions
===========

Policies
-----------

- All policies (policy files) installed in `./lib/policies` directory. 
  Note: There could be other policy directories added in the future, like for example `~/.banalizer` or similar
- There are two classes of policies recognized by Banalizer: ruby and 'other'
- Ruby policy files detected by `.rb` extension. Files without `.rb` extension are considered to be 'others'
- Policy name is detected from
  - file name of 'other' policy
  - first argument for `banalizer` method for Ruby policy
- all names should be unique, or they will be overwritten


### Non-ruby policies (i.e. others)

Every 'other; policy should conform to few rules:
- it must return information about itself when called with parameter `config`
  - Output of the `config` command is YAML formatted text
  - Attributes of the YAML structure are
      - severity
      - policy
      - name
      - description
      - help
  - All attributes are optional. 
    They are either set to default values if missing, or detected from other meta-data (like, for example, name of a policy is `$(basename file)` of policy file.
- it must be able to perform single check on bash script file and
  - return non-zero status if check fails or 0 if succeeds
  - return (optional) error massages on STDOUT
  **Note**: Only STDOUT is honored by Banalizer. If your check command returns errors on STDERR and STDOUT is not important, you need to redirect shell streams correspondingly.





### policy name

- Must correspond to file name.
  - non-ruby policies get their name from `$(basename $0)`
  - Ruby policy must define class with the camelized name of ruby-plugin file:
      - file: `shebang_format.rb`
      - class: `ShebangFormat`
    

### Config section

Each policy produces self-help in YAML

```yaml
    ---
    :name: $(basename $0)
    :policy: 
      - :bug
      - :test
    :severity: 5
    :description: Runs bash syntax check using 'bash -n' option
```

* YAML keys are Ruby symbols (i.e. have leading colon ':')
* Policy can be Symbol or Array of Symbols

### DSL

DSL provides methods with the same names as keys in YAML config section:

```ruby
  description "Check format of shebang"
  severity    5
```

Each Ruby policy inherits from {Banalize::Policy}


