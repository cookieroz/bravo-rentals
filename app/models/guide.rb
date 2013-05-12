class Guide < ActiveRecord::Base
  attr_accessible :arrival, :eatout, :history, :name, :overview, :weather,
                  :whatdo, :whengo, :destination_id, :guide_image_attributes
       
  belongs_to :destination

  has_one :guide_image, as: :imageable, class_name: "Photo"

  accepts_nested_attributes_for :guide_image

  include PgSearch
  multisearchable :against => [:arrival, :eatout, :history, :name, :overview, :weather,
                               :whatdo, :whengo]  
    
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
end
