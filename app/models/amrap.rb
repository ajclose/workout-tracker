class Amrap < ApplicationRecord
  include PgSearch
  belongs_to :workout
  has_many :amrapmovements, dependent: :destroy
  validates :time, presence: true

  multisearchable :against => [:name]
end
