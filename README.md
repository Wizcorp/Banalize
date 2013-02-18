# @title Banalize README

Name
===========

Banalize - Bash code analyzer



Conventions
===========

Policies
-----------

- All policies (policy files) installed in `./lib/plugins` directory. 
- Ruby files detected by `.rb` extension


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


