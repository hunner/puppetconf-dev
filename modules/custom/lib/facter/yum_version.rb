IO.popen('yum list installed').readlines.each do |line|
  if line =~ /^(\S+)\.(i386|x86_64|noarch)\s+(\S+)\s+(installed)$/
    package = $1 and version = $3
    Facter.add("yum_#{package}_version") do
      confine :has_yum => 'true',
              :operatingsystem => ["centos","redhat","fedora"]
      setcode { version }
    end
  end
end
