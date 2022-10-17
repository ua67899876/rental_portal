class ApartmentsController < ApplicationController
  before_action :set_apartment, only: %i[edit update rent_apartment]

  def index
    @apartments = Apartment.search(params[:type])
  end

  def create
    @apartment = current_user.apartments.new(apartment_params)
    if @apartment.save
      redirect_to apartments_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @apartment.update(apartment_params)
      redirect_to apartments_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  
  def set_apartment
    @apartment = Apartment.find(params[:id])
  end
  
  def apartment_params
    params.require(:apartment).permit(:owner_id, :location, :rent, :apartment_type)
  end
end
