class AppointmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.owner?
        user.moderator_appointments.not_visited
      else
        user.requester_appointments.not_visited
      end
    end


    def index
      true
    end
  end
end
