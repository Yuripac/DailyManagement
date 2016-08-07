require 'test_helper'

class TeamTest < ActiveSupport::TestCase

  setup do
    @john = users(:john)
    @arya = users(:arya)
    @ned  = users(:ned)

    @starks     = teams(:starks)
    @bastards   = teams(:bastards)
    @boltons    = teams(:boltons)
    @targaryens = teams(:targaryens)
  end

  test "should get yesterday dailies" do
    expected = [dailies(:john_to_starks_yesterday),
                dailies(:ned_to_starks_yesterday)].sort
    yesterday_dailies = @starks.yesterday_dailies.sort
    assert_equal yesterday_dailies, expected
  end

  test "should get empty array when has no yesterday dailies" do
    assert_empty @boltons.yesterday_dailies
  end

  test "should get today dailies" do
    expected = [dailies(:john_to_starks_today),
                dailies(:ned_to_starks_today)].sort
    today_dailies = @starks.today_dailies.sort
    assert_equal today_dailies, expected
  end

  test "should get empty array when has no today dailies" do
    assert_empty @boltons.today_dailies
  end

  test "should get true when user is owner" do
    assert @bastards.owned_by?(@john)
  end

  test "should get false when user isn't owner" do
    assert_not @starks.owned_by?(@john)
  end

  test "should get true when user is member" do
    assert @starks.member?(@john)
  end

  test "should get false when user isn't member" do
    assert_not @boltons.member?(@john)
  end

  test "should get false if paramenter isn't user when check if owner" do
    not_user = "not a user"
    assert_not @starks.owned_by?(not_user)
  end

  test "should get users that updated daily today" do
    users = @starks.valid_daily_members.sort
    expected = [@ned, @john].sort
    assert_equal users, expected
  end

  test "should get empty array when no users updated daily today" do
    assert_empty @boltons.valid_daily_members
  end

  test "should get true when user updated daily today" do
    assert @starks.valid_daily_member?(@john)
  end

  test "should get false when user doesn't updated daily today" do
    assert_not @starks.valid_daily_member?(@arya)
  end

  test "should get last user's daily" do
    last_daily = @starks.last_daily_by_user(@john)
    expected = dailies(:john_to_starks_today)
    assert_equal last_daily, expected
  end

  test "should get nil when user has not a last daily" do
    assert_nil @starks.last_daily_by_user(@arya)
  end

end
