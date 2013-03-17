class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :name
      t.string :slug
      t.text :content
      t.text :todo
      t.text :airport
      t.text :rentcar
      t.text :weather
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.string :address
      t.timestamps
    end
    add_index :destinations, :slug, unique: true
  end
end
