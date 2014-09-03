class DailyScrum < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :user
  validates :scrum_date, presence: true, uniqueness: { scope: :scrum_user }
  validates :sprint_id, presence: true
  validates :scrum_yesterday, presence: true
  validates :scrum_today, presence: true
end
