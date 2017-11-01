class Workout < ApplicationRecord
  belongs_to :user
  has_many :amrap, dependent: :destroy
  has_many :rft, dependent: :destroy
  has_many :strength, dependent: :destroy
  validates :date, presence: true, uniqueness: true

end
