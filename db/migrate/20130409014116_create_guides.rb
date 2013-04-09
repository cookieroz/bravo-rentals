class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
      t.string :name
      t.string :slug
      t.references :destination
      t.text :overview
      t.text :arrival
      t.text :whatdo
      t.text :whengo
      t.text :weather
      t.text :eatout
      t.text :history

      t.timestamps
    end
    add_index :guides, :destination_id
    add_index :guides, :slug, unique: true
  end
end
