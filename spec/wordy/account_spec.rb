require 'spec_helper'

describe Wordy::Account do
  describe "Checking account balance" do  
    it "should return the amount of money still available" do
      Wordy::Cli.stub!(:http_get).and_return({"balance"=>"$666"})
      Wordy::Account.balance.should == 666.0
    end
    
    it "should return the amount of money still available with decimals" do
      Wordy::Cli.stub!(:http_get).and_return({"balance"=>"$666.50"})
      Wordy::Account.balance.should == 666.50
    end
    
    it "should return the amount of money still available even if no currency symbol is present" do
      Wordy::Cli.stub!(:http_get).and_return({"balance"=>"666.50"})
      Wordy::Account.balance.should == 666.50
    end
    
    it "should return nil if Wordy returns nothing" do
      Wordy::Cli.stub!(:http_get).and_return({})
      Wordy::Account.balance.should be_nil
    end
  end
end