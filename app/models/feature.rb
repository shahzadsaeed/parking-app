class Feature < ApplicationRecord
  has_and_belongs_to_many :slots

  validates :name, :value, presence: true
end
