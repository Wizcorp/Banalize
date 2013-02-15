desc 'List available policies'

arg_name ''
command :list do |c|

  c.desc 'Only names of policies without description (default)'
  c.switch [:short, :s]
  c.default_value true

  c.desc 'Only names of policies without description (default). Overrides `--short`'
  c.switch [:full, :f]
  c.default_value false

  c.desc 'Show only policies included in specified group'
  c.default_value 'core'
  c.flag [:group, :g]

  c.action do |global_options,options,args|

    Banalize::Policy.files[:other].each do |x|
      print "---\npolicies:\n"
      print %x{ #{x} config }
    end
  end
end
