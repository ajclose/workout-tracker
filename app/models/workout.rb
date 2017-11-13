class Workout < ApplicationRecord
  include PgSearch
  belongs_to :user
  has_many :amrap, dependent: :destroy
  has_many :rft, dependent: :destroy
  has_many :strength, dependent: :destroy
  validates :date, presence: true, :uniqueness => {:scope => :user_id}

  def text_date
    date.strftime("%A, %B %d, %Y")
  end

  multisearchable :against => [:text_date]

end
