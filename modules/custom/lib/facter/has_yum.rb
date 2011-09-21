yum = "/usr/bin/yum"
if File.exist?(yum) and File.executable?(yum)
  Facter.add("has_yum") do
    setcode { true }
  end
end
