require "application_system_test_case"

class MemberActivationTest < ApplicationSystemTestCase
  def setup
    sign_in_as_admin
  end

  test "activate pending member without membership" do
    @member = create(:member)

    visit admin_member_url(@member)

    assert_content "Member not active"
    click_on "activated"

    select "State", from: "Photo ID"
    first("label", text: "Address verified").click
    click_on "Activate Membership"

    assert_content "Does not have an active membership"
    click_on "Create Membership"

    fill_in "This year's membership fee", with: "35"
    select "cash", from: "Payment source"

    click_on "Save Membership"

    assert_content "Current membership expires on"
  end

  test "activate pending member without membership using square" do
    @member = create(:member)

    visit admin_member_url(@member)

    assert_content "Member not active"
    click_on "activated"

    select "State", from: "Photo ID"
    first("label", text: "Address verified").click
    click_on "Activate Membership"

    assert_content "Does not have an active membership"
    click_on "Create Membership"

    fill_in "This year's membership fee", with: "43"
    select "square", from: "Payment source"

    click_on "Save Membership"

    assert_content "Current membership expires on"
  end

  test "activate pending member with a membership" do
    @member = create(:member)
    create(:membership, member: @member)

    visit admin_member_url(@member)

    assert_content "Member not active"
    click_on "activated"

    select "State", from: "Photo ID"
    first("label", text: "Address verified").click
    click_on "Activate Membership"

    assert_content "Current membership expires on"
  end

  test "create membership without a payment" do
    @member = create(:active_member)

    visit admin_member_url(@member)

    click_on "Create Membership"
    click_on "Create Membership Without Payment"

    assert_content "Current membership expires on"

    click_on "Membership History"
    assert_content "$0.00"
  end
end
