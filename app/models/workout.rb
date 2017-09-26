class Workout < ApplicationRecord
  belongs_to :user
  has_one :amrap, dependent: :destroy
  validates :date, presence: true

end
