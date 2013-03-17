require 'spec_helper'

describe "rentals/edit" do
  before(:each) do
    @rental = assign(:rental, stub_model(Rental))
  end

  it "renders the edit rental form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rentals_path(@rental), :method => "post" do
    end
  end
end
