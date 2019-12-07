class Advertisement < ApplicationRecord
   validates :title, :store_id, :product_url, :description, :image_url, :collection_id, :effective_date, :expiration_date, presence: true
   # validates :store_id, presence: true
   # validates :product_url, presence: true
   # validates :description, presence: true
   # validates :image_url, presence: true
   # validates :collection_id, presence: true
   # validates :effective_date, presence: true
   # validates :expiration_date, presence: true
   
   validate :effective_date_cannot_be_in_the_past
   validate :expiration_date_cannot_be_before_effective_date

   belongs_to :collection
   belongs_to :store

   MAX_ADS_PER_STORE = 3

   def self.max_ads_reached?(store_id:)
      Advertisement.where(store_id: store_id).count >= MAX_ADS_PER_STORE 
   end

   def self.remove_expired_ads
      Advertisement.destroy_by(expiration_date: Date.today)
      # Advertisement.destroy_by(description: 'delete')
   end

   def effective_date_cannot_be_in_the_past
      if effective_date.present? && effective_date < Date.today
        errors.add(:effective_date, "can't be in the past")
      end
   end    

    def expiration_date_cannot_be_before_effective_date
      if expiration_date.present? && expiration_date < effective_date
        errors.add(:expiration_date, "can't be before effective date")
      end
   end 
end
