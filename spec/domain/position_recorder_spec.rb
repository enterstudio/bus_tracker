require "no_rails_spec_helper"
require "position_recorder" 
require "rgeo"

describe PositionRecorder do

  context "storing from hash" do
    Given(:route) {flexmock("route")}
    Given(:position_creator) {flexmock("creator", :create! => true)}
    Given(:recorder) {PositionRecorder.new(route, position_creator)}
    Given(:position_hash) {{"lat"=>"39.950916", "lng"=>"-75.175949", "label"=>"8077", "VehicleID"=>"8077", "BlockID"=>"7260", "Direction"=>"WestBound", "destination"=>"50th - Woodland", "Offset"=>"1"}}

    When { recorder.record_position!(position_hash) }

    Then { position_creator.should have_received(:create!).and {|args|
      args[:bus_route].should == route}
    }
    And { position_creator.should have_received(:create!).and {|args|
      args[:bus_id].should == "8077"}
    }
    And { position_creator.should have_received(:create!).and {|args|
      args[:block_id].should == "7260"}
    }
    And { position_creator.should have_received(:create!).and {|args|
      args[:location].to_s.should == "POINT (-75.175949 39.950916)"}
    }
    And { position_creator.should have_received(:create!).and {|args|
      args[:direction].should == "WestBound"}
    }
    And { position_creator.should have_received(:create!).and {|args|
      args[:destination].should == "50th - Woodland"}
    }
    And { position_creator.should have_received(:create!).and {|args|
      args[:reported_at].to_i.should == about((Time.now - 60).to_i).delta(3)}
    }
  end
end
