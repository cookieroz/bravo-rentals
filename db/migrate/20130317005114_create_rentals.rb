class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.string :name
      t.string :slug
      t.references :destination
      t.integer :sleeps, :default => 4
      t.integer :bedrooms, :default => 2
      t.float :bathrooms, :default => 1.5
      t.text :content
      t.text :rates
      t.text :observations
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps

      t.timestamps
    end
    add_index :rentals, :destination_id
    add_index :rentals, :slug, unique: true
  end
end
