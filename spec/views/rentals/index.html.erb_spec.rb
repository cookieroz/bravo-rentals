require 'spec_helper'

describe "rentals/index" do
  before(:each) do
    assign(:rentals, [
      stub_model(Rental),
      stub_model(Rental)
    ])
  end

  it "renders a list of rentals" do
    render
  end
end
