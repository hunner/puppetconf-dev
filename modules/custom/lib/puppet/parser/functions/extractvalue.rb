require 'yaml'

Puppet::Parser::Functions.newfunction(:extractvalue, :type => :rvalue, :doc => "This function extracts values") do |args|
  begin
    emails = YAML.load_file(args[0])
    raise Puppet::Error, "No value found" if ! emails[args[1]]
    emails[args[1]] 
  rescue => e
    raise Puppet::Error, e.message
  end
end
