require 'pry'
require 'spec_helper'
require 'capybara'

feature "add video as admin" do
  given(:admin) { Fabricate(:user, admin: true) }
  given(:user) { Fabricate(:user) }
  scenario 'admin succesfully adds new video' do
    sign_in(admin)

    visit new_admin_video_path

    add_video

    expect(page).to have_content "The video has been added"

    visit logout_path

    sign_in(user)

    visit root_path

    visit video_path(Video.first.id)

    expect(page).to have_content "This is the title"

  end

  private

  def add_video
    fill_in "Title", :with => "This is the title"
    fill_in "Description", :with => 'This is the description'
    attach_file("Large image", "spec/support/uploads/r.png")
    attach_file("Small image", "spec/support/uploads/r.png")
    fill_in "Url", :with => "http://s3.amazonaws.com/myflix_test/movies/HW4%20Solution.mp4"
    click_button "Add New Video"
  end

  def sign_in(user)
    visit login_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Submit"
  end
end
