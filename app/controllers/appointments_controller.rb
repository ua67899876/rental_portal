class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[update]
  def index
    @appointments = policy_scope(Appointment.eager_load(:apartment, :requester, :moderator))
  end

  def create
    @apartment = Apartment.find(params[:apartment_id])
    appointment = Appointment.new(apartment: @apartment, requester: current_user, moderator: @apartment.owner)

    if appointment.save
      redirect_to appointments_path
    else
      flash[:error] = "Could not save appointment"
      redirect_to appointments_path
    end
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to appointments_path
    else
      render :edit
    end
  end

  def visited
    @appointment = Appointment.find(params[:appointment_id])

    @appointment.update(status: :visited)
    redirect_to appointments_path
  end

  private

  def appointment_params
    params.require(:appointment).permit(:start_at).tap do |pp|
      pp[:status] = :pending
    end
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end
