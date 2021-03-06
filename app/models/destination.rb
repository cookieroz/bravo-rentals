class Destination < ActiveRecord::Base
  attr_accessible :airport, :content, :latitude, :longitude, :name, :rentcar, :todo,
                  :weather, :address, :rentals_attributes, :guides_attributes,
                  :photo_attributes
  attr_accessor :image, :file

  validates :name,  :presence => true

  has_many :rentals
  has_many :guides
  has_one :photo, as: :imageable, :dependent => :destroy, class_name: "Photo"

  accepts_nested_attributes_for :rentals
  accepts_nested_attributes_for :guides
  accepts_nested_attributes_for :photo

  acts_as_gmappable :latitude => 'latitude', :longitude => 'longitude', :process_geocoding => :geocode?,
                    :address => "address", :normalized_address => "address",
                    :msg => "Sorry, not even Google could figure out where that is"

  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?)) || address_changed?
  end

  include PgSearch
  multisearchable :against => [:name, :airport, :content, :rentcar, :todo, :weather]

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
end
