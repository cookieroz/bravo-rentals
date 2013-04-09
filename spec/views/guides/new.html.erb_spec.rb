require 'spec_helper'

describe "guides/new" do
  before(:each) do
    assign(:guide, stub_model(Guide,
      :name => "MyString",
      :overview => "MyText",
      :arrival => "MyText",
      :whatdo => "MyText",
      :whengo => "MyText",
      :weather => "MyText",
      :eatout => "MyText",
      :history => "MyText"
    ).as_new_record)
  end

  it "renders new guide form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => guides_path, :method => "post" do
      assert_select "input#guide_name", :name => "guide[name]"
      assert_select "textarea#guide_overview", :name => "guide[overview]"
      assert_select "textarea#guide_arrival", :name => "guide[arrival]"
      assert_select "textarea#guide_whatdo", :name => "guide[whatdo]"
      assert_select "textarea#guide_whengo", :name => "guide[whengo]"
      assert_select "textarea#guide_weather", :name => "guide[weather]"
      assert_select "textarea#guide_eatout", :name => "guide[eatout]"
      assert_select "textarea#guide_history", :name => "guide[history]"
    end
  end
end
