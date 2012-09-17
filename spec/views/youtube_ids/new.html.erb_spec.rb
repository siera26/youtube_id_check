require 'spec_helper'

describe "youtube_ids/new" do
  before(:each) do
    assign(:youtube_id, stub_model(YoutubeId,
      :y_id => "MyString",
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new youtube_id form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => youtube_ids_path, :method => "post" do
      assert_select "input#youtube_id_y_id", :name => "youtube_id[id]"
    end
  end
end
