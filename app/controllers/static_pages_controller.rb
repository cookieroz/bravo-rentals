class StaticPagesController < ApplicationController
  def about
  end

  def home
    @rentals = Rental.scoped.limit(4).order("RANDOM()")
    @destinations = Destination.all
  end

  def contact
    @message = Message.new
  end

  def search
    @pg_search_documents = PgSearch.multisearch(params[:q]) #.select(ts_headline('english', "text", plainto_tsquery('"endpoints"'), 'MaxFragments=0, MinWords=5, MaxWords=9'))
  end
end
