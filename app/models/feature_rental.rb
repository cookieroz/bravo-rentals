class FeatureRental < ActiveRecord::Base
  attr_accessible :rental_id, :feature_id

  belongs_to :feature
  belongs_to :rental
end
