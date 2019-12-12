class Advertisement < ApplicationRecord
   validates :title, :store_id, :product_url, :description, :image_url, :collection_id, :effective_date, :expiration_date, presence: true
   
   validate :effective_date_cannot_be_in_the_past
   validate :expiration_date_cannot_be_before_effective_date
   validate :expiration_date_cannot_be_today

   belongs_to :collection
   belongs_to :store

   MAX_ADS_PER_STORE = 3

   def self.max_ads_reached?(store_id:)
      Advertisement.where(store_id: store_id).count >= MAX_ADS_PER_STORE 
   end

   def self.remove_expired_ads
      # Advertisement.destroy_by('expiration_date <= ?', Date.today)
      if destroyed_records = Advertisement.destroy_by(description: 'del')
        puts "****************** SUCCESSFUL! ****************"
        puts "destroyed record with id: #{destroyed_records.map(&:id)}"
      else
        puts "****************** FAILED! ****************"
      end
   end

   def effective_date_cannot_be_in_the_past
      if effective_date.present? && effective_date < Date.today
        errors.add(:effective_date, "can't be in the past")
      end
   end    

    def expiration_date_cannot_be_before_effective_date
      if expiration_date.present? && expiration_date <= effective_date
        errors.add(:expiration_date, "can't be before the effective date or the same day")
      end
   end 

   def expiration_date_cannot_be_today
      if expiration_date.present? && expiration_date == Date.today
        errors.add(:expiration_date, "can't be today")
      end
   end 
end
