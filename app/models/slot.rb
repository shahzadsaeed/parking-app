class Slot < ApplicationRecord
  has_many :reservations
  has_and_belongs_to_many :features

  scope :available_slots, lambda {
    where(available: true)
  }

  # Validations
  validates :start_time, presence: true
  validates :end_time, presence: true
end
