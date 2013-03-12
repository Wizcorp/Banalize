desc 'Run banalize on a single file or multiple files'

arg_name 'filename', :multiple
command [:file, :fl] do |c|
  
  c.desc "Show all results, by default only failures shown (only for long format)"
  c.switch [:a,:all]

  c.desc "Short dotted output format"
  c.switch [:s, :short, :dots]

  c.desc "With 'no-' do not show errors, only name of failed check"
  c.default_value true
  c.switch [:errors, :err, :e]


  c.action do |global, options, args|
    args.each { |file| $res[file] = Banalize.run(file, $search) }
  end
end


