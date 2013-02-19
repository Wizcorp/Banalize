policy :shebang_format do
  
  help 'Format of shebang should be #!/usr/bin/env bash'
  severity    5

  def run 
    lines.first =~ %r{^\#!/usr/bin/env\s+bash}
  end
end
