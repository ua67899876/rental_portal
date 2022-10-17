class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :apartments, foreign_key: :owner_id

  has_many :requester_appointments, foreign_key: :requester_id, class_name: "Appointment"
  has_many :moderator_appointments, foreign_key: :moderator_id, class_name: "Appointment"

  enum user_type: {
    owner: 0,
    renter: 1,
    receptionist: 2
  }
end
