Puppet::Type.type(:rcsrepo).provide(:git) do
  commands :git => 'git'

  def revision
    gitdir("rev-parse", "HEAD").chomp
  end

  def revision=(value)
    gitdir("fetch","origin")
    gitdir("checkout", value)
  end

  def gitdir(*args)
    git("--work-tree", resource[:path], "--git-dir", resource[:path] + File::SEPARATOR + '.git', args)
  end

  def exists?
    File.directory?(resource[:path] + File::SEPARATOR + ".git")
  end

  def create
    if resource[:source]
      git("clone", resource[:source], resource[:path])
      self.revision = resource[:revision] if resource[:revision] and self.revision != resource[:revision]
    else
      git("init", resource[:path])
    end
  end

  def destroy
    FileUtils.rm_rf(resource[:path])
  end
end
