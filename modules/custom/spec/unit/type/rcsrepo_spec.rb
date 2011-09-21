require 'puppet'
require 'puppet/type/rcsrepo'
describe Puppet::Type.type(:rcsrepo) do
  before :each do
    @rcsrepo = Puppet::Type.type(:rcsrepo).new(:path => '/foo')
  end
  it 'should accept ensure' do
    @rcsrepo[:ensure] = "present"
    @rcsrepo[:ensure].should == :present
  end
  it 'should require that path be absolute' do
    @rcsrepo[:path] = "/foo"
    @rcsrepo[:path].should == "/foo"
    expect { @rcsrepo[:path] = "foo" }.should raise_error( Puppet::Error, /not an absolute path/)
  end
  it 'should not accept whitespace in a revision' do
    expect { @rcsrepo[:revision] = "some revision" }.should raise_error(Puppet::Error)
  end
  it 'should accept a valid source URI' do
    @rcsrepo[:source] = "https://foo.com/bar.git"
    @rcsrepo[:source].should == "https://foo.com/bar.git"
  end
  it 'should not accept an invalid source URI' do
    expect { @rcsrepo[:source] = "hg://foo.com" }.should raise_error
  end
end
