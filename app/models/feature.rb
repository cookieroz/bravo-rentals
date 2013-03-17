class Feature < ActiveRecord::Base
  attr_accessible :name

  has_many :rentals, through: :feature_rentals
end
