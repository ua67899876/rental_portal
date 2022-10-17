class Apartment < ApplicationRecord
  belongs_to :owner, class_name: :User, foreign_key: :owner_id
  has_many :deeds, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :owners, through: :deeds, source: :owner, dependent: :destroy
  has_many :renters, through: :deeds, source: :renter, dependent: :destroy

  validates :owner_id, :apartment_type, :location, presence: true
  validates :rent, numericality: {greater_than: 0}
  validate :existing_owner, on: ['create']

  validate :can_update_rent?, on: :update

  enum apartment_type: {
    studio: 0,
    one_bed: 1,
    two_bed: 2,
    duplex: 3
  }

  scope :search, ->(type) do
    return includes(:deeds).all if type.blank?

    includes(:deeds).where(apartment_type: type)
  end

  def rent_available?
    return true if deeds.empty?

    deeds.rent.where(Deed.arel_table[:ends_on].lt(Date.current)).exists?
  end

  def existing_owner
    raise StandardError.new("You already own this property") if owner_id_was == owner_id
  end

  private

  def can_update_rent?
    return if Date.current - updated_at.to_date > 30.days && rent_changed?

    errors.add(:rent, "can't be updated before 30 days")
  end
end
