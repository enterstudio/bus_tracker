require 'spec_helper'

describe BusRoute do
  it "requires a unique name" do
    BusRoute.create(:name=>"12")
    BusRoute.new(:name=>"12").should have(1).error_on(:name)
  end

  it "Has a named method" do
    twelve = BusRoute.create(:name=>"12")
    BusRoute.named("12").should == twelve
  end
end
