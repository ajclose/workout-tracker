class Strength < ApplicationRecord
  include PgSearch
  belongs_to :workout
  validates :movement, :sets, :reps, :weight, presence: true

  multisearchable :against => [:movement]

end
