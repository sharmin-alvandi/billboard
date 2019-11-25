class CreateAdvertisements < ActiveRecord::Migration[6.0]
  def change
    create_table :advertisements do |t|
      t.string :title
      t.integer :store_id
      t.string :product_url
      t.string :description
      t.string :image_url
      t.integer :collection_id

      t.timestamps
    end
  end
end
