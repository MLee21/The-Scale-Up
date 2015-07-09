require "rails_helper"

describe "the user signup" do
  include Capybara::DSL

  before(:each) do
    ActionMailer::Base.deliveries.clear
  end

  it "with valid signup information" do
    visit root_path
    click_link("Sign up")

    expect do
      post users_path, user: { full_name: "Steve Jobs",
                               display_name: "stevejobs",
                               email: "steve@jobs.com",
                               street_1: "111 Main St.",
                               city: "Portland",
                               state: "OR",
                               zipcode: 97003,
                               password: "password",
                               password_confirmation: "password"
                             }
    end.to change { User.count }

    user = assigns(:user)
    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_link_or_button("Log in")
    expect(current_path).to eq(root_path)
  end
end
