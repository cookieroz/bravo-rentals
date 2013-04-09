require 'spec_helper'

describe "guides/edit" do
  before(:each) do
    @guide = assign(:guide, stub_model(Guide,
      :name => "MyString",
      :overview => "MyText",
      :arrival => "MyText",
      :whatdo => "MyText",
      :whengo => "MyText",
      :weather => "MyText",
      :eatout => "MyText",
      :history => "MyText"
    ))
  end

  it "renders the edit guide form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => guides_path(@guide), :method => "post" do
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
