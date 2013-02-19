policy "Format of shebang should be #!/usr/bin/env bash" do
  
  severity    5

  def run 
    lines.first =~ %r{^\#!/usr/bin/env\s+bash}
  end
end
