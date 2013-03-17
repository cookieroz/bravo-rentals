class CreateFeatureRentals < ActiveRecord::Migration
  def change
    create_table :feature_rentals do |t|
      t.integer  :feature_id
      t.integer  :rental_id

      t.timestamps
    end
  end
end
