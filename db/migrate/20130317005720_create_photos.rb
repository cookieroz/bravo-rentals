class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :caption
      t.integer :rental_id
      t.string :image
      t.integer :imageable_id
      t.string :imageable_type
      t.integer :image_uid
      t.string :image_name
      t.string :path
      t.string :name
      t.integer :position
      t.timestamps
    end
  end
end
