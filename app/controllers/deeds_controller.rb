class DeedsController < ApplicationController
  before_action :set_apartment, only: [:new, :create]
  before_action :set_deed, only: :new

  def create
    @deed = @apartment.deeds.new(deed_params)

    if @deed.save
      redirect_to apartments_path
    else
      render :new
    end
  end

  private

  def set_apartment
    @apartment = Apartment.find(params[:apartment_id])
  end

  def set_deed
    @deed = Deed.find_by(id: params[:id]) || Deed.new
  end

  def deed_params
    params.require(:deed).permit(:starts_on, :ends_on).tap do |params|
      params[:apartment] = @apartment
      params[:owner] = @apartment.owner
      params[:renter] = current_user
      params[:deed_type] = :rent
    end
  end
end
