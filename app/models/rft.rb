class Rft < ApplicationRecord
  belongs_to :workout
  has_many :rftmovements
  validates :rounds, presence: true
end
