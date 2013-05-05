class StaticPagesController < ApplicationController
  def about
    if params[:name]
      @destinations = Destination.find_all_by_name(params[:name])
    else
      @destinations = Destination.all
    end
  end

  def home
    @rentals = Rental.scoped.limit(4).order("RANDOM()")
    @guides = Guide.scoped.limit(1).order("id DESC")
  end

  def contact
    @message = Message.new
  end

  def search
    @pg_search_documents = PgSearch.multisearch(params[:q]) #.select(ts_headline('english', "text", plainto_tsquery('"endpoints"'), 'MaxFragments=0, MinWords=5, MaxWords=9'))
  end

  def owners
    @message = Message.new
  end
end
