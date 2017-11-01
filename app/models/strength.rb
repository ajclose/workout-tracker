class Strength < ApplicationRecord
  belongs_to :workout
  validates :movement, :sets, :reps, :weight, presence: true
end
