class Deed < ApplicationRecord
  belongs_to :owner, class_name: :User, foreign_key: :owner_id
  belongs_to :renter, class_name: :User, foreign_key: :renter_id
  belongs_to :apartment, class_name: :Apartment, foreign_key: :apartment_id

  validates :deed_type, :starts_on, :owner_id, presence: true
  validate :valid_owner

  enum deed_type: {
    sale: 0,
    rent: 1
  }

  def valid_owner
    raise StandardError.new("Owner can not rent their own property") if owner_id == renter_id
  end
end
