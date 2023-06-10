class Customer::ReservationsController < ApplicationController
  before_action :authenticate_user
  before_action :set_reservation, only: %I[update destroy check_in check_out cancel]

  def index
    reservations = current_user.reservations
    render json: reservations_response(reservations)
  end

  def create
    reservation = Reservation.new(reservation_params)
    if reservation.save
      render json: { reservation: reservation, slot: reservation.slot, customer: reservation.customer }, status: :created
    else
      render json: reservation.errors, status: :unprocessable_entity
    end
  end

  def update
    if @reservation.update(reservation_params)
      render json: { reservation: @reservation, slot: @reservation.slot, customer: @reservation.customer }
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    head :no_content
  end

  def check_in
    @reservation.update(checked_in: true)
    render json: { reservation: @reservation, slot: @reservation.slot, customer: @reservation.customer }
  end

  def check_out
    @reservation.update(checked_out: true)
    render json: { reservation: @reservation, slot: @reservation.slot, customer: @reservation.customer }
  end

  def complete
    @reservation.update(status: :complete)
    render json: { reservation: @reservation, slot: @reservation.slot, customer: @reservation.customer }
  end

  def cancel
    if @reservation.cancel_reservation
      render json: { message: 'Reservation cancelled successfully' }
    else
      render json: { error: 'Cancellation failed' }, status: :unprocessable_entity
    end
  end

  private

  def reservations_response(reservations)
    reservations.map { |res| { reservation: res, slot: res.slot, customer: res.customer } }
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_time, :end_time, :checked_in, :checked_out, :slot_id,
                                        :customer_id, :car_number_plate, :status)
  end
end
