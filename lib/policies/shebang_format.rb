class ShebangFormat < Banalize::Policy

  description "Check format of shebang"
  severity    5
  
  def run 
    lines.first =~ %r{^\#!/usr/bin/env\s+bash}
  end

end
