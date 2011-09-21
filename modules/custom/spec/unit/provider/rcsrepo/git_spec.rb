require 'puppet'
require 'fileutils'
require 'mocha'
RSpec.configure do |config|
  config.mock_with :mocha
end
provider_class = Puppet::Type.type(:rcsrepo).provider(:git)
describe provider_class do
  before :each do
    @test_dir = File.join('/tmp', Time.now.to_i.to_s, 'repo')
    @resource = Puppet::Type::Rcsrepo.new({:path => @test_dir})
    @provider = provider_class.new(@resource)
  end
  it 'should be able to create a new repo' do
    @provider.expects(:git).with("init", @provider.resource[:path])
    @provider.create
  end
  it 'should be able to stubbily clone a repo' do
    source = "http://github.com/hunner/PSU-puppet-dev.git"
    @provider.expects(:git).with("clone", source, @provider.resource[:path])
    @provider.resource[:source] = source
    @provider.create #Called with stub
  end
  it 'should be able to really clone a repo' do
    source = "http://github.com/hunner/PSU-puppet-dev.git"
    @provider.resource[:source] = source
    @provider.create #Called without stub
    @provider.exists?.should == true
  end
  it 'should be able to query if a repo exists' do
    @provider.exists?.should == false
    @provider.create
    @provider.exists?.should == true
  end
  it 'should ensure that destroy removes the repo' do
    @provider.create
    @provider.exists?.should == true
    @provider.destroy
    @provider.exists?.should == false
  end
  it 'should be able to check the revision' do
    source = "http://github.com/hunner/PSU-puppet-dev.git"
    @provider.resource[:source] = source
    @provider.create
    #require 'debug' ruby-debug
    @provider.revision.should == "eddfb1025c2b5cac52b46d6c4296b9a2dc63a395"
  end
  it 'should be able to clone and checkout revision' do
    source = "http://github.com/hunner/PSU-puppet-dev.git"
    revision = "a0a39fdb6fbad701047d14710d13d2a2d642f1df"
    @provider.resource[:source] = source
    @provider.resource[:revision] = revision
    @provider.create
    @provider.revision.should == revision
  end
  it 'should be able to modify a revision' do
    source = "http://github.com/hunner/PSU-puppet-dev.git"
    revision = "a0a39fdb6fbad701047d14710d13d2a2d642f1df"
    @provider.resource[:source] = source
    @provider.create
    @provider.resource[:revision] = revision
    @provider.expects(:gitdir).with("fetch", "origin")
    @provider.expects(:gitdir).with("checkout", revision)
    @provider.revision = revision
  end
  after :each do
    FileUtils.rm_rf(File.dirname(@test_dir))
  end
end
