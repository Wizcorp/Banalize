desc 'Run banalize on single file'

arg_name 'filename'
command :file do |c|
  
  c.desc "Show all results, by default only failures shown (only for long format)"
  c.switch [:a,:all]

  c.desc "Short dotted output format"
  c.switch [:d, :dotted]

  c.action do |global, options, args|

    file = args.first
    help unless file
    $res = { file => Banalize.run(args.first, $search) }

  end
end


