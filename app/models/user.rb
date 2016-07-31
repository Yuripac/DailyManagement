class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :membership_teams, through: :memberships, source: :team

  has_many :teams, dependent: :destroy
  has_many :dailies

  validates :first_name, :last_name, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  def missing_dailies_teams
    membership_teams.select do |t|
      t.user != self && !t.valid_daily_member?(self)
    end
  end
end
