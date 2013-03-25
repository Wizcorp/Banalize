desc 'Banalize file(s) from single or multiple directories. Can use wildcards and mix files/directories.'

arg_name 'dir', :multiple
command [:directory, :dir] do |c|

  c.desc "Show all results, by default only failures shown (only for long format)"
  c.switch [:a,:all]

  c.desc "Short dotted output format"
  c.switch [:s, :short, :dots]

  c.desc "Recursive scan directories for files"
  c.switch [:recursive, :recur, :r]

  c.switch [:allow_files, :f], :desc => "Allow use of file paths together with directory paths"

  c.desc "Wildcard for file lists"
  c.default_value "*"
  c.flag [:wildcard, :w]

  c.desc "With 'no-' do not show errors, only name of failed check"
  c.default_value true
  c.switch [:errors, :err, :e]

  c.action do |global, options, args|
    files = []
    args.each { |dir|
      dir = File.expand_path dir
      if options[:allow_files] && File.file?(dir)
        files << dir
      else
        files += Dir.glob("#{dir}/#{ options[:r] ? '**/' : ''}#{options[:wildcard]}").select { |x| File.file? x}
      end
    }
    files.each { |file| $res[file] = Banalize.run(file, $search) }
  end
end


