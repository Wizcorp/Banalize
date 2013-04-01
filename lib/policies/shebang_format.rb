banalizer :shebang_format do
  
  description 'Format of shebang should be #!/usr/bin/env bash'

  parser :bash

  def run
    unless shebang.has?(%r{\#!/usr/bin/env\s+bash})
      errors.add "Expected first line to be '#!/usr/bin/env bash'"
      errors.add "    Shebang line is '#{shebang.to_s}'"
    end
    return errors.empty?
  end
  
end
