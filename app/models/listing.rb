class Listing < ActiveRecord::Base
	validates :user, presence: true, length: { maximum: 50 }
	validates :listing_type, presence: true
	validates :postal_code, presence: true, numericality: { only_integer: true }
	validates :status, presence: true
	validate :type_of_listing
	validate :status_of_listing

	def type_of_listing
		if self.listing_type == "rent" || self.listing_type == "sale"
			return true
		else
			errors.add(:listing_type, "should be either rent or sale")
		end
	end

	def status_of_listing
		if self.status == "active" || self.status == "closed" || self.status == "deleted"
			return true
		else
			errors.add(:status, "should be active, closed or deleted")
		end
	end
end
