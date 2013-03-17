class RentalsController < ApplicationController
  # GET /rentals
  # GET /rentals.json
  def index
    @rentals = Rental.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rentals }
    end
  end

  # GET /rentals/1
  # GET /rentals/1.json
  def show
    @rental = Rental.find(params[:id])
    @json = @rental.to_gmaps4rails
    @images = @rental.photos
    @message = Message.new

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

        format.html { redirect_to @rental, notice: 'Villa was successfully updated.' }
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
