banalizer :shebang_format do
  
  help 'Format of shebang should be #!/usr/bin/env bash'

  def run
    unless lines.first =~ %r{^\#!/usr/bin/env\s+bash}

      errors.add "First line is not in the format #!/usr/bin/env bash", 1
      return false
    end
  end

end
