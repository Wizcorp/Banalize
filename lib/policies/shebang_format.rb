banalizer :shebang_format do
  
  description 'Format of shebang should be #!/usr/bin/env bash'

  def run
    unless shebang =~ %r{^\#!/usr/bin/env\s+bash}

      errors.add "First line is not in the format #!/usr/bin/env bash", 1
      errors.add "Shebang line is #{shebang}", 1
      return false
    end
  end

end
