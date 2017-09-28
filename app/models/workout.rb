class Workout < ApplicationRecord
  belongs_to :user
  has_many :amrap, dependent: :destroy
  validates :date, presence: true, uniqueness: true

end
