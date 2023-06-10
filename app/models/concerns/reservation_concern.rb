module ReservationConcern
  extend ActiveSupport::Concern

  included do
    def cancellable?
      Time.now < start_time
    end

    def cancel_reservation
      return unless cancellable?

      cancellation_charges = calculate_cancellation_charges
      save
      customer.update(status: :canceled, cancellation_charges: customer.cancellation_charges.to_f + cancellation_charges)
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
  end

  def end_time_after_start_time
    errors.add(:end_time, 'must be after the start time') if start_time.present? && end_time.present? && end_time <= start_time
  end

  def check_slot_availability
    return true unless slot_id.present?

    slot = Slot.find(slot_id)
    if slot.reservations.where('start_time <= ? AND end_time >= ?', end_time, start_time).present?
      errors.add(:end_time, 'Slot already booked in the given time')
    end
  end

  def check_customer_availability
    return true unless customer_id.present?

    customer = Customer.find(customer_id)
    if customer.reservations.where('start_time <= ? AND end_time >= ?', end_time, start_time).present?
      errors.add(:end_time, 'Customer has already booked a slot in given time')
    end
  end
end
