class Rental < ActiveRecord::Base
  belongs_to :destination

  attr_accessible :bathrooms, :bedrooms, :content, :latitude, :longitude, :name, :feature_ids,
                  :observations, :rates, :sleeps, :destination_id, :photos_attributes,
                  :features_attributes

  validates :name,  :presence => true

  has_many :photos, :as => :imageable, :dependent => :destroy, :order => :position
  has_many :feature_rentals
  has_many :features, through: :feature_rentals, :dependent => :destroy

  accepts_nested_attributes_for :features,  allow_destroy: true

  include PgSearch
  multisearchable :against => [:bathrooms, :bedrooms, :content, :name, :observations,
                               :rates, :sleeps]

  acts_as_gmappable

  def gmaps4rails_address
    "#{self.latitude}, #{self.longitude}"
  end

  #def self.by_destinations(destination)
  #  joins(:destination).where('destination_id = ?', destination.to_i)
  #end

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
end
