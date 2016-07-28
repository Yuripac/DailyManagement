class Daily < ActiveRecord::Base

  belongs_to :team
  belongs_to :user

  validates :done, :doing, :impediments, length: { maximum: 500}
  validates :user, :team, presence: true
  validates :user, uniqueness: { scope: [:team, :created_at],
    message: "Already has a daily to this team today"}

  # def self.created_today?(user, team)
  #   dailies = user.dailies.where(team: team)
  #   !dailies.empty? && dailies.last.created_at >= Time.zone.now.beginning_of_day
  # end
end
