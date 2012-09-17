require "spec_helper"

describe YoutubeIdsController do
  describe "routing" do

    it "routes to #index" do
      get("/youtube_ids").should route_to("youtube_ids#index")
    end

    it "routes to #new" do
      get("/youtube_ids/new").should route_to("youtube_ids#new")
    end

    it "routes to #create" do
      post("/youtube_ids").should route_to("youtube_ids#create")
    end

    it "routes to #destroy" do
      delete("/youtube_ids/1").should route_to("youtube_ids#destroy", :id => "1")
    end

  end
end
