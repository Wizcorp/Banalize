$: << File.dirname(__FILE__)

require 'gli'

require 'banalize/version'
require 'banalize/policy'

include GLI::App
Dir.glob("#{File.dirname(__FILE__)}/commands/*.rb").each do |f|
  require f
end
