class Slot < ApplicationRecord
  has_many :reservations

  # Validations
  validates :start_time, presence: true
  validates :end_time, presence: true
end
