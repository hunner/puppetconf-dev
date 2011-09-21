Facter.add("listening_ports") do
  setcode do
    ports = IO.popen("netstat -tnl").readlines.collect do |line|
      m = line.match(/\:(\d+)\s/)
      m[1].to_i if m
    end
    ports.compact.sort.join(',')
  end
end
