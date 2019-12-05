class RemoveExpirationFromAdvertisements < ActiveRecord::Migration[6.0]
  def change

    remove_column :advertisements, :expiration, :datetime
  end
end
