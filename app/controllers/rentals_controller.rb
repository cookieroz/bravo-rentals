class RentalsController < ApplicationController
  # GET /rentals
  # GET /rentals.json
  def index
    if params[:q].present?
      params[:q][:start_date] = Time.parse(params[:q][:start_date]).to_i if params[:q][:start_date].present?
      params[:q][:end_date] = Time.parse(params[:q][:end_date]).to_i if params[:q][:end_date].present?
      destination = Destination.where(id: params[:q][:destination_id]).first
      params[:q][:destination_name] = destination.name.parameterize if destination
      redirect_to filter_rentals_path(params[:q]) and return
    end

    @photos = Photo.all
    if params[:destination_id]
      #@destinations = Destination.all
      @rentals = Rental.find_all_by_destination_id(params[:destination_id])
    elsif params[:sleeps]
      @rentals = Rental.find_all_by_sleeps(params[:sleeps][:num])
    elsif params[:bedrooms]
      @rentals = Rental.find_all_by_bedrooms(params[:bedrooms][:num])
    else
      @rentals = Rental.all
    end

    @rentals_no_filter = Rental.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rentals }
    end
  end

  def filter
    params[:start_date] = Time.at(params[:start_date].to_i).to_date if params[:start_date].present?
    params[:end_date] = Time.at(params[:end_date].to_i).to_date if params[:end_date].present?
    @rentals = Rental
    @rentals = @rentals.where("sleeps >= ?", params[:sleeps]) if params[:sleeps].present?
    @rentals = @rentals.where("bedrooms >= ?", params[:bedrooms]) if params[:bedrooms].present?
    @rentals = @rentals.joins(:destinations).where("destinations.id" => params[:destination_id]) if params[:destination_id].present?
    @rentals = @rentals.order("sleeps DESC")
    if params[:start_date].present? && params[:end_date].present?
      overlaped_villas = Villa.
        joins(:reservations).
        where("start_date <= ? AND end_date >= ?", params[:end_date], params[:start_date])

      @rentals = @rentals.where("rentals.id not in (?)", overlaped_villas) if overlaped_villas.any?
    end

    @rentals_no_filter = Rental.all

    @photos = Photo.all

    respond_to do |format|
      format.html { render "index" }
      format.json { render :json => @photos.collect { |p| p.to_jq_upload }.to_json  }
    end
  end

  # GET /rentals/1
  # GET /rentals/1.json
  def show
    @rental = Rental.find(params[:id])
    @json = @rental.to_gmaps4rails
    @images = @rental.photos
    @message = Message.new

    @rentals = Rental.scoped.limit(2).order("RANDOM()")

    add_breadcrumb "#{@rental.destination.name}", destination_path(@rental.destination)
    add_breadcrumb "Vacation Rentals", rentals_path

    add_breadcrumb "#{@rental.name}", rental_path

    #@photo = @rental.photos.build
    @photos = Photo.scoped(:conditions => [ 'rental_id = ?', @rental.id ] )

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rental }
    end
  end

  # GET /rentals/new
  # GET /rentals/new.json
  def new
    @rental = Rental.new
    @object_new = Photo.new

    respond_to do |format|
      format.html # _new.html.erb
      format.json { render json: @rental }
    end
  end

  # GET /rentals/1/edit
  def edit
    @rental = Rental.find(params[:id])
    @object_new = Photo.new
  end

  # POST /rentals
  # POST /rentals.json
  def create
    #@rental = Rental.new(params[:rental])
    rental_data = params[:rental]
    photo_ids = rental_data.delete :photo_ids
    @rental = Rental.new(rental_data)

    respond_to do |format|
      if @rental.save
        update_photos_with_rental_id photo_ids, @rental

        format.html { redirect_to @rental, notice: 'Rental was successfully created.' }
        format.json { render json: @rental, status: :created, location: @rental }
      else
        @object_new = Photo.new
        format.html { render action: "new" }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rentals/1
  # PUT /rentals/1.json
  def update
    @rental = Rental.find(params[:id])
    rental_data = params[:rental]
    photo_ids = rental_data.delete :photo_ids

    respond_to do |format|
      if @rental.update_attributes(rental_data)
        update_photos_with_rental_id photo_ids, @rental

        format.html { redirect_to @rental, notice: 'Rental was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rentals/1
  # DELETE /rentals/1.json
  def destroy
    @rental = Rental.find(params[:id])
    @rental.destroy

    respond_to do |format|
      format.html { redirect_to rentals_url }
      format.json { head :no_content }
    end
  end

  def sort_photos
    params[:photos].each_with_index do |id, index|
      Photo.update_all({position: index+1}, {id: id})
    end

    render nothing: true
  end

  private
  def update_photos_with_rental_id photo_ids, rental
    photo_ids.split(',').each do |id|
      photo = Photo.where(id: id).first
      if photo.present?
        photo.imageable = rental
        photo.save
      end
    end
  end
end
