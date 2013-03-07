banalizer :shebang_format do
  
  description 'Format of shebang should be #!/usr/bin/env bash'

  parser :bash

  def run
    unless shebang.has?(%r{\#!/usr/bin/env\s+bash})
      errors.add "Expected first line to be #!/usr/bin/env bash", 1
      errors.add "Instead shebang line is #{shebang.to_s}", 1
    end
    return errors.empty?
  end
  
end
