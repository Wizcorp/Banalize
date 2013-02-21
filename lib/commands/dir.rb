desc 'Run banalize in derectory with bash files'
desc 'Run banalize on a single file or multiple files'

arg_name 'dir', :multiple
command [:directory, :dir] do |c|
  
  c.desc "Show all results, by default only failures shown (only for long format)"
  c.switch [:a,:all]

  c.desc "Short dotted output format"
  c.switch [:s, :short, :dots]

  c.desc "Recursive scan directories for files"
  c.switch [:recursive, :recur, :r]

  c.desc "Wildcard for file lists"
  c.default_value "*"
  c.flag [:wildcard, :w]

  c.action do |global, options, args|
    args.each { |dir| 
      dir = File.expand_path dir
      files = Dir.glob("#{dir}/#{ options[:r] ? '**/' : ''}#{options[:wildcard]}").select { |x| File.file? x}
      files.each { |file| $res[file] = Banalize.run(file, $search) }
    }
  end
end


