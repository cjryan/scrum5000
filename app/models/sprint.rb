class Sprint < ActiveRecord::Base
  has_many :daily_scrum
  validates :sprint_number, presence: true, uniqueness: true, numericality: { only_integer: true }
end
