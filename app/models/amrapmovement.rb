class Amrapmovement < ApplicationRecord
  belongs_to :amrap

  validate :movement_present?

  def movement_present?
    if %w(rx_movement scaled_movement).all?{|attr| self[attr].blank?}
      errors.add :base, "Please enter a movement name"
    end
  end
end
