class AddExpirationToAdvertisements < ActiveRecord::Migration[6.0]
  def change
    add_column :advertisements, :expiration, :datetime
  end
end
