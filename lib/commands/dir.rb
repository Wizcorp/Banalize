desc 'Banalize file(s) from single or multiple directories. Can use wildcards and mix files/directories.'

arg_name 'dir', :multiple
command [:directory, :dir] do |c|


  c.switch [:a,:all],                desc: "Show all results, not only failures (for long format)"
  c.switch [:dots, :d],              desc: "Short dotted output format"
  c.switch [:recursive, :recur, :r], desc: "Recursive scan directories for files"
  c.switch [:allow_files, :f],       desc: "Allow use of file paths together with directory paths"

  c.flag   [:wildcard, :w],          desc: "Wildcard for file lists", default_value: "*"
  c.flag   [:except,  :ex],          desc: "Skip files with listed extensions (comma-separated)"

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
    ##
    # Filter out files by extentions
    #
    if options[:except]

      extensions = options[:except]

      extensions = extensions.split(/\s*,\s*/) if
        extensions.is_a? String

      extensions.each do |ext|
        files.reject! {  |file| file =~ /.*\.#{ext}/ }
      end
    end

    files.each { |file| $res[file] = Banalize.run(file, $search) }

  end
end

