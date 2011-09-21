Puppet::Type.newtype(:rcsrepo) do

  ensurable

  newproperty(:revision) do
    desc "The checked-out revision of the repository"
    newvalues(/^\S+$/)
  end
  newparam(:path, :namevar => true) do
    desc "The location to store the repo"
    validate do |value|
      raise ArgumentError, "Path is not an absolute path: #{value}" unless value =~ /^\//
    end
  end
  newparam(:source) do
    desc "The source URI for the repo"
    validate do |value|
      raise ArgumentError, "Source is not a http(s) or git URL: #{value}" unless value =~ /^(https?|git|svn):\/\//
    end
    munge do |value|
      #resource[:provider] = :git if value =~ /^git:\/\//
      value
    end
  end
end
