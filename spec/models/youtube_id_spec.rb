require 'spec_helper'

describe YoutubeId do
  describe 'validation test' do
    before(:all) do
      @youtube_id = FactoryGirl.build(:youtube_id, :y_id => 'g0OzSpzYe6I')
      @youtube_id.save
    end
    
    it "should be able to create a new y_id" do
      puts @youtube_id.errors.inspect
      @youtube_id.should be_valid
    end
    
    it "should require y_id to be unique" do
      youtube_id = YoutubeId.new(:y_id => 'g0OzSpzYe6I', :name => 'test')
      youtube_id.save
      youtube_id.should_not be_valid
      youtube_id.errors[:y_id].should eq(["has already been taken"])
    end
    
    it "should require y_id to be not empty" do
      @youtube_id.update_attributes({:y_id => ''})
      @youtube_id.should_not be_valid
      @youtube_id.errors[:y_id].should eq(["can't be blank"])
    end
    
    after(:all) do
      @youtube_id.delete
    end
  end
end
