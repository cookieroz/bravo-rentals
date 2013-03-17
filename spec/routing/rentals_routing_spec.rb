require "spec_helper"

describe RentalsController do
  describe "routing" do

    it "routes to #index" do
      get("/rentals").should route_to("rentals#index")
    end

    it "routes to #new" do
      get("/rentals/new").should route_to("rentals#new")
    end

    it "routes to #show" do
      get("/rentals/1").should route_to("rentals#show", :id => "1")
    end

    it "routes to #edit" do
      get("/rentals/1/edit").should route_to("rentals#edit", :id => "1")
    end

    it "routes to #create" do
      post("/rentals").should route_to("rentals#create")
    end

    it "routes to #update" do
      put("/rentals/1").should route_to("rentals#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/rentals/1").should route_to("rentals#destroy", :id => "1")
    end

  end
end
