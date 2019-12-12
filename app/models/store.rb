class Store < ApplicationRecord
  belongs_to :user
  has_many :advertisements
  before_destroy :ensure_not_referenced_by_any_advertisement

  private
    # ensure that there are no advertisements referencing this store
    def ensure_not_referenced_by_any_advertisement
      unless advertisements.empty?
        errors.add(:base, 'Advertisements present')
        throw :abort 
      end
    end

end
