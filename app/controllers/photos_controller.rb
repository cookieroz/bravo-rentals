class PhotosController < ApplicationController
  # GET /pictures
  # GET /pictures.json
  def index
    @rental = Rental.find(params[:rental_id])
    @photos = @rental.photos.order(:position)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @photos.collect { |p| p.to_jq_upload }.to_json }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.json
  def new
    @rental = Rental.find(params[:rental_id])
    @photo = @rental.photos.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /pictures/1/edit
  def edit
    @rental = Rental.find(params[:rental_id])

    @photo = @rental.photos.find(params[:id])
    # @photo = Photo.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.json
  def create
    #p_attr = params[:photo]
    # p_attr[:image] = params[:photo][:image].first if params[:photo][:image].class == Array

    @photo = Photo.new(params[:photo])

    if @photo.save
      respond_to do |format|
        format.html {
          render :json => @photo.to_jq_upload.to_json,
                 :content_type => 'text/html',
                 :layout => false
        }
        format.json {
          render :json => @photo.to_jq_upload.to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.json
  def update

    @rental = Rental.find(params[:rental_id])

    @photo = @rental.photos.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to rental_path(@rental), notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    #@rental = Rental.find(params[:rental_id])
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :json => true }
    end
  end

  def make_default
    @photo = Photo.find(params[:id])
    @rental = Rental.find(params[:rental_id])

    respond_to do |format|
      format.js
    end
  end
end
