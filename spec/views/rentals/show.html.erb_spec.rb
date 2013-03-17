require 'spec_helper'

describe "rentals/show" do
  before(:each) do
    @rental = assign(:rental, stub_model(Rental))
  end

  it "renders attributes in <p>" do
    render
  end
end
