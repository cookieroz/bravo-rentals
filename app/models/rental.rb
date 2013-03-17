class Rental < ActiveRecord::Base
  belongs_to :destination

  attr_accessible :bathrooms, :bedrooms, :content, :latitude, :longitude, :name,
                  :observations, :rates, :sleeps, :destination_id, :photos_attributes

  validates :name,  :presence => true

  has_many :photos, :as => :imageable, :dependent => :destroy, :order => :position

  include PgSearch
  multisearchable :against => [:bathrooms, :bedrooms, :content, :name, :observations,
                               :rates, :sleeps]

  acts_as_gmappable

  def gmaps4rails_address
    "#{self.latitude}, #{self.longitude}"
  end

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
end
