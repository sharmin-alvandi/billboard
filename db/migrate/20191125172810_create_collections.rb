class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections do |t|
      t.string :title

      t.timestamps
    end

    create_table :advertisements do |t|
      t.string :title
      # t.integer :store_id
      t.belongs_to :store, index: true
      t.string :product_url
      t.string :description
      t.string :image_url
      # t.integer :collection_id
      t.belongs_to :collection, index: true

      t.timestamps
    end
    
  end
end
