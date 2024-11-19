class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show]

  # def myaccount
  #   @bookings = Booking.where(user_id: current_user.id)
  #   @bookings.each do |booking|
  #     booking.brain = Brain.find(booking.brain_id)
  #   end
  # end

  def show
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @booking.brain = Brain.find(params[:brain_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.brain = Brain.find(params[:brain_id])
    if @booking.save
      redirect_to brain_path(@booking.brain)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end