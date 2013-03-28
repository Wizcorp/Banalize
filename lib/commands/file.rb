desc 'Run banalize on a single file or multiple files'

arg_name 'filename', :multiple
command [:file, :fl] do |c|


  c.switch [:a,:all],   desc: "Show all results, not only failures (for long format)"
  c.switch [:dots, :d], desc: "Short dotted output format"

  c.desc "With 'no-' do not show errors, only name of failed check"
  c.default_value true
  c.switch [:errors, :err, :e]


  c.action do |global, options, args|
    args.each { |file| $res[file] = Banalize.run(file, $search) }
  end
end


