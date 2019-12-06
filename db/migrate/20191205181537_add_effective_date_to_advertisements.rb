class AddEffectiveDateToAdvertisements < ActiveRecord::Migration[6.0]
  def change
    add_column :advertisements, :effective_date, :datetime
  end
end
