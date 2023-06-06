class Reservation < ApplicationRecord
  belongs_to :slot
  belongs_to :customer
  
  # Validations
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time

  def cancellable?
    Time.now < start_time
  end
  
  def cancel_reservation
    if cancellable?
        cancellation_charges = calculate_cancellation_charges
      save
      customer.update(cancellation_charges: customer.cancellation_charges.to_f + cancellation_charges)
    end
  end

  def calculate_cancellation_charges
    # If the cancellation is done before 24 hours of the start time, no charges
    # If the cancellation is done between 24 hours and 1 hour before the start time, 50% charges
    # If the cancellation is done within 1 hour of the start time, 100% charges

    if (start_time - Time.now) >= 24.hours
      # Cancellation before 24 hours, no charges
      0
    elsif (start_time - Time.now) > 1.hour
      # Cancellation between 24 hours and 1 hour, 50% charges
      total_price * 0.5
    else
      # Cancellation within 1 hour, 100% charges
      total_price
    end
  end

  private

  def end_time_after_start_time
    if start_time.present? && end_time.present? && end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
end
