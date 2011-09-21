Facter.add('gem_count') do
  setcode do
    IO.popen('gem list').readlines.length.to_s
  end
end
