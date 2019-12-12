class CreateUsers < ActiveRecord::Migration[6.0]

  def change
    
    create_table :stores do |t|
      t.string :title
      t.belongs_to :user, index: :true
      
      t.timestamps
    end

    create_table :users do |t|
      t.string :username
      t.string :password_digest

      t.timestamps
    end


  end
end
