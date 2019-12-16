class CreateStores < ActiveRecord::Migration[6.0]
  def change

    create_table :users do |t|
      t.string :username
      t.string :password_digest

      t.timestamps
    end

    create_table :advertisements do |t|
      t.string :title
      # t.integer :store_id
      t.belongs_to :store, index: true
      t.string :product_url
      t.string :description
      t.string :image_url
      t.datetime :effective_date
      t.datetime :expiration_date
      t.active :boolean
      # t.integer :collection_id
      t.belongs_to :collection, index: true

      t.timestamps
    end

    create_table :stores do |t|
      # t.integer :user_id
      t.belongs_to :user, index: true
      t.string :title

      t.timestamps
    end

  end
end
