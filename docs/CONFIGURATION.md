# @title Banalizer configuration

![banalize](images/banalize_small.png)

# Per user configuration

## Command line options

All command line options for Banalizer can be set as defaults in `~/.banalizer/config` file. `config` file is in YAML format. 

See [GLI configuration](https://github.com/davetron5000/gli/wiki/Config) for details.

## Policies defaults

Defaults defined in policy recipes using `default`method  (see {Banalize::Registry.default}) can be overwritten by per-user or per-project custom styles file. 

Default locatio for the style file is `~/.banalize/style`. It's YAML formatted file. Example is available in Banalize project config directory. Please see for details.
