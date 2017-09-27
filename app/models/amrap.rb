class Amrap < ApplicationRecord
  belongs_to :workout
  has_many :amrapmovements, dependent: :destroy
  validates :time, presence: true
end
