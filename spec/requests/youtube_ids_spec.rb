require 'spec_helper'

describe "YoutubeIds" do
  describe "GET /youtube_ids" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get youtube_ids_path
      response.status.should be(200)
    end
  end
end
