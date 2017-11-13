class Rft < ApplicationRecord
  include PgSearch
  belongs_to :workout
  has_many :rftmovements, dependent: :destroy
  validates :rounds, presence: true

  multisearchable :against => [:name]
end
