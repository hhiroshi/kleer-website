require File.join(File.dirname(__FILE__),'../lib/keventer_event_type')

describe KeventerEventType do
  
  before(:each) do
    @keventype = KeventerEventType.new
  end
  
  it "should have a name" do
    @keventype.name = "Workshop de Retrospectivas"
    @keventype.name.should == "Workshop de Retrospectivas"
  end
  
  it "should have a goal" do
    @keventype.goal = "Buenos Aires"
    @keventype.goal.should == "Buenos Aires"
  end
  
  it "should have a description" do
    @keventype.description = "Argentina"
    @keventype.description.should == "Argentina"
  end
  
  it "should have a elevator_pitch" do
    @keventype.elevator_pitch = "Argentina"
    @keventype.elevator_pitch.should == "Argentina"
  end
  
  it "should have a learnings" do
    @keventype.learnings = "Argentina"
    @keventype.learnings.should == "Argentina"
  end
  
  it "should have a takeaways" do
    @keventype.takeaways = "Argentina"
    @keventype.takeaways.should == "Argentina"
  end
  
  it "should have a program" do
    @keventype.program = "ar"
    @keventype.program.should == "ar"
  end
  
  it "should have a duration" do
    @keventype.duration = 16
    @keventype.duration.should == 16
  end
  
  it "should have some recipients" do
    @keventype.recipients = "sdkjfhskjfhskdjf"
    @keventype.recipients.should == "sdkjfhskjfhskdjf"
  end
  
  it "should have some FAQs" do
    @keventype.faqs = "sdkjfhskjfhskdjf"
    @keventype.faqs.should == "sdkjfhskjfhskdjf"
  end  
  
  
end