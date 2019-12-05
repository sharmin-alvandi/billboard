class AddActiveToAdvertisements < ActiveRecord::Migration[6.0]
  def change
    add_column :advertisements, :active, :boolean
  end
end
