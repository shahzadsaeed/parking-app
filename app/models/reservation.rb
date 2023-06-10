class Reservation < ApplicationRecord
  include ReservationConcern

  belongs_to :slot
  belongs_to :customer

  # Validations
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time
  validate :check_slot_availability
  validate :check_customer_availability

  enum status: { booked: 0, canceled: 1, completed: 2 }
end
