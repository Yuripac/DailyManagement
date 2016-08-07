class Team < ActiveRecord::Base

  paginates_per 10

  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user

  belongs_to :user

  has_many :dailies, dependent: :destroy

  validates :name, :description, :user, presence: true
  validates :description, length: { maximum: 200 }

  after_create :add_owner_to_membership

  def self.search(query)
    where("name like ?", "%#{query}%")
  end

  def member?(user)
    members.include? user
  end

  def owned_by?(user)
    self.user == user
  end

  def yesterday_dailies
    dailies.yesterday
  end

  def today_dailies
    dailies.today
  end

  def valid_daily_members
    today_dailies.map { |d| d.user }
  end

  def valid_daily_member?(user)
    valid_daily_members.include?(user)
  end

  def dailies_grouped_by_created_at
    dailies.group_by { |d| d.created_at.to_date }
  end

  def last_daily_by_user(user)
    dailies.where(user: user).order("created_at asc").last
  end

  private

  def add_owner_to_membership
    members << user
  end
end
