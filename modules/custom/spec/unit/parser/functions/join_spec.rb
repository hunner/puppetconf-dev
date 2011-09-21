require 'puppet'
describe Puppet::Parser::Functions.function(:join) do
  before :each do
    @scope = Puppet::Parser::Scope.new
  end
  it "should turn an array of items into a string" do
    @scope.function_join([['foo','bar','baz'], ':']).should == 'foo:bar:baz'
  end
  it "should fail if the first argument is not an array" do
    expect { @scope.function_join(["foo",":"]) }.should raise_error(Puppet::Error, /Incorrect arguments/)
  end
  it "should fail if the second argument is not a string" do
    expect { @scope.function_join([["foo"],[":"]]) }.should raise_error(Puppet::Error, /Incorrect arguments/)
    expect { @scope.function_join([["foo"],1]) }.should raise_error(Puppet::Error, /Incorrect arguments/)
  end
  it "should fail if the number of argument is incorrect" do
    expect { @scope.function_join([":"]) }.should raise_error(Puppet::Error, /Incorrect number of arguments/)
  end
end
