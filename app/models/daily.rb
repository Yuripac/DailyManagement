class Daily < ActiveRecord::Base

  belongs_to :team
  belongs_to :user

  validates :done, :doing, :impediments, length: { maximum: 500}
  validates :user, :team, presence: true
  validates :user, uniqueness: { scope: [:team, :created_at],
    message: "Already has a daily to this team today"}

  scope :today,     ->{ where("created_at >= ?", Time.zone.now.beginning_of_day) }
  scope :yesterday, ->{ where("date(created_at) = ?", Time.zone.yesterday) }
end
