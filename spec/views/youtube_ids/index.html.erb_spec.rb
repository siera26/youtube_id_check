require 'spec_helper'

describe "youtube_ids/index" do
  before(:each) do
    assign(:youtube_ids, [
      stub_model(YoutubeId,
        :y_id => "Id",
        :name => "Name"
      ),
      stub_model(YoutubeId,
        :y_id => "Id",
        :name => "Name"
      )
    ])
  end

  it "renders a list of youtube_ids" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Id".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
