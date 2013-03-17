require 'spec_helper'

describe "rentals/new" do
  before(:each) do
    assign(:rental, stub_model(Rental).as_new_record)
  end

  it "renders new rental form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rentals_path, :method => "post" do
    end
  end
end
