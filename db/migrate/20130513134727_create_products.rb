class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :genere
      t.string :platform
      t.decimal :price, :precision => 8, :scale => 2
      t.string :image_url

      t.timestamps
    end
  end
end
