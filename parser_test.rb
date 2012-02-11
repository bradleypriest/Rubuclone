require 'rspec'
require './parser'

describe Parser do
  it "should match all matches in 123" do
    Parser.new('(\d)', '123').matches.should == ['1','2','3']
  end

  it "should match the right matches" do
    Parser.new('(\d)', 'abc123').matches.should == ['1','2','3']
  end

  it "should match the right matches" do
    Parser.new('(\d)', 'abc123abc').matches.should == ['1','2','3']
  end

  it "should match the right matches" do
    Parser.new('(\d)', '123abc').matches.should == ['1','2','3']
  end

  it "should match the right matches" do
    Parser.new('(\d)', 'a1a2a3a').matches.should == ['1','2','3']
  end
end