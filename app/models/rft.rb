class Rft < ApplicationRecord
  belongs_to :workout
  has_many :rftmovements, dependent: :destroy
  validates :rounds, presence: true
end
