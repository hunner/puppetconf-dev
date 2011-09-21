Puppet::Parser::Functions.newfunction(:join, :type => :rvalue) do |args|
  raise Puppet::Error, "Incorrect number of arguments; expected 2, got #{args.length}" if args.length != 2
  raise Puppet::Error, "Incorrect arguments; expected Array and got #{args[0].class}" unless args[0].is_a? Array
  raise Puppet::Error, "Incorrect arguments; expected String and got #{args[1].class}" unless args[1].is_a? String
  args[0].join args[1]
end
