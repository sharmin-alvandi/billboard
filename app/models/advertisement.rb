class Advertisement < ApplicationRecord
   validate :effective_date_cannot_be_in_the_past
   validate :expiration_date_cannot_be_before_effective_date
   belongs_to :collection
   belongs_to :store
  
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
