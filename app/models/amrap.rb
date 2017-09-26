class Amrap < ApplicationRecord
  belongs_to :workout
  validates :time, presence: true
end
