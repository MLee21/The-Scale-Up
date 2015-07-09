require "rails_helper"

describe "the user" do
  include Capybara::DSL
  attr_reader :item, :user

  it "sees a Login button on homepage" do
    visit root_path

    expect(page).to have_link("Login")
    expect(page).to_not have_link("Logout")
  end

  it "a user going to a non defined route gets redirected to the home page" do
    visit "/something"

    expect(current_path).to eq(root_path)
  end

  it "redirects a user to the home page if trying to access admin dash" do
    visit "/admin"

    expect(current_path).to eq(root_path)
  end

  it "cannot log in with invalid credentials" do
    visit root_path
    click_link("Login")
    fill_in "session[email]", with: ""
    fill_in "session[password]", with: ""
    click_link_or_button("Log in")

    expect(page).to have_content("Invalid Login")
  end

  it "can see a signup button" do
    visit root_path
    click_link("Login")

    expect(page).to have_link("here")
  end

  it "can create an account" do
    user = build(:user)

    visit root_path
    click_link("Sign up")
    fill_in "user[full_name]", with: user.full_name
    fill_in "user[display_name]", with: user.display_name
    fill_in "user[email]", with: user.email
    fill_in "user[street_1]", with: user.street_1
    fill_in "user[city]", with: user.city
    select  "Oregon", from: "user[state]"
    fill_in "user[zipcode]", with: user.zipcode
    fill_in "user[password]", with: user.password
    fill_in "user[password_confirmation]", with: user.password
    click_button("Create my account!")
  end

  it "cannot create an account with invalid credentials" do
    user = create(:user)

    visit root_path
    click_link("Sign up")
    fill_in "user[full_name]", with: "123"
    fill_in "user[display_name]", with: "a"
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: "pass"
    fill_in "user[password_confirmation]", with: "word"
    click_button("Create my account!")
    expect(page).to have_content("invalid")
  end

  it "can login" do
    user = create(:user)

    visit root_path
    click_link_or_button("Login")
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button("Log in")

    expect(page).to have_content("Successfully logged in")
  end

  it "is redirected back to the page it came from when sign up from nav bar" do
    user = build(:user)

    visit tickets_path
    post users_path, user: {
      full_name: user.full_name,
      display_name: user.display_name,
      email: user.email,
      street_1: "111 Main St.",
      city: "Portland",
      state: "OR",
      zipcode: 97003,
      password: user.password,
      password_confirmation: user.password
    }

    expect(current_path).to eq tickets_path
  end

  it "is redirected back to the page it came from after login from nav bar" do
    user = create(:user)
    visit tickets_path

    click_link("Login")
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button("Log in")

    expect(current_path).to eq tickets_path
  end

  it "is redirected back to the page it came from after sign up through login" do
    user = build(:user)
    visit tickets_path

    click_link("Login")
    click_link("here")
    fill_in "user[full_name]", with: user.full_name
    fill_in "user[display_name]", with: user.display_name
    fill_in "user[email]", with: user.email
    fill_in "user[street_1]", with: user.street_1
    fill_in "user[city]", with: user.city
    select  "Oregon", from: "user[state]"
    fill_in "user[zipcode]", with: user.zipcode
    fill_in "user[password]", with: user.password
    fill_in "user[password_confirmation]", with: user.password
    click_button("Create my account!")

    expect(current_path).to eq root_path
  end

  it "is redirected to the order summary after login from checkout" do
    event = create(:event)
    seller = create(:user)
    create(:item, event: event, user_id: seller.id)
    user= create(:user)
    visit event_path(event)
    click_button("Add to cart")

    visit cart_path
    click_link("Checkout")
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_button("Log in")

    expect(current_path).to eq new_order_path
  end

  it "is redirected to review order when sign up from checkout" do
    event = create(:event)
    seller = create(:user)
    create(:item, event: event, user_id: seller.id)
    user= build(:user)
    visit event_path(event)
    click_button("Add to cart")

    visit cart_path
    click_link("Checkout")
    click_link("here")
    fill_in "user[full_name]", with: user.full_name
    fill_in "user[display_name]", with: user.display_name
    fill_in "user[email]", with: user.email
    fill_in "user[street_1]", with: user.street_1
    fill_in "user[city]", with: user.city
    select  "Oregon", from: "user[state]"
    fill_in "user[zipcode]", with: user.zipcode
    fill_in "user[password]", with: user.password
    fill_in "user[password_confirmation]", with: user.password
    click_button("Create my account!")

    expect(current_path).to eq root_path
  end

  it "sees a Logout button instead of Login " do
    mock_user

    visit root_path

    expect(page).to_not have_link("Login")
    expect(page).to have_link("Logout")
  end

  it "cannot see another users information" do
    exisiting_user = create(:user)

    mock_user
    order = Order.create(user_id: exisiting_user.id, status:  "ordered")

    visit seller_order_path(exisiting_user.slug, order.id)

    expect(current_path).to eq(root_path)
  end

  it "can log out" do
    mock_user

    visit root_path
    click_link("Logout")

    expect(page).to have_content("Successfully logged out")
  end

  it "sees a review order page after clicking checkout" do
    mock_user
    event = create(:event)
    create(:item, event_id: event.id)
    visit event_path(event)
    click_link_or_button("Add to cart")

    visit cart_path
    click_link_or_button("Checkout")

    expect(page).to have_content("Review Your Order!")
    expect(page).to have_button("Submit Order")
    click_link_or_button("Submit Order")
    expect(page).to have_content("Order Details")
  end

  it "gets redirected to home page if user tries to access admin page" do
    mock_user

    visit admin_path

    expect(current_path).to eq(root_path)
  end

  describe "the seller dashboard" do
    it "exists" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(user)

      visit seller_dashboard_path(user.slug)
      within(".seller-page-title") do
        expect(page).to have_content("#{user.full_name}'s Dashboard")
      end
    end

    it "does not allow other users to access other seller dashboard" do
      user1 = create(:user)
      user2 = create(:user, display_name: "nickcage", email: "here@h.com")

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(user1)

      visit seller_dashboard_path(user2.slug)

      expect(current_path).to eq(root_path)
    end

    it "show's all the tickets for a seller" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(user)

      event = create(:event, category_id: 1)
      ticket = create(:item, event_id: event.id, user_id: user.id)

      visit seller_dashboard_path(user.slug)

      expect(page).to have_content(ticket.section)
      expect(page).to have_content(ticket.row)
      expect(page).to have_content(ticket.seat)
    end

    it "shows the users profile" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(user)

      visit seller_dashboard_path(user.slug)

      expect(page).to have_content("User Profile")
      expect(page).to have_content(user.full_name)
      expect(page).to have_content(user.display_name)
      expect(page).to have_content(user.slug)
    end

    it "lets users edit their profile" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(user)

      visit seller_dashboard_path(user.slug)
      click_link_or_button("Edit User Profile")
      fill_in "user[full_name]", with: "New Name"
      fill_in "user[display_name]", with: "namer"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      click_link_or_button("Update Account")

      expect(page).to have_content("New Name")
      expect(page).to have_content("namer")
    end

  end

  describe "the past orders view" do
    it "shows the past orders for a user" do
      mock_user
      visit root_path

      click_link("Past Orders")

      expect(current_path).to eq(seller_orders_path(@user.slug))
      expect(page).to have_content("Orders for #{@user.full_name}")
    end

    it "shows the details for a past order" do
      mock_user
      order = Order.create(user_id: @user.id)
      item = create(:item)
      order_item = OrderItem.create(order_id: order.id, item_id: item.id)
      order.order_items << order_item

      visit root_path
      click_link("Past Orders")

      expect(page).
        to have_content("#{order.id}")
      within("tbody") do
        expect(page).to have_content("#{item.dollar_amount}")
      end
    end
  end

  def mock_user
    @user = create(:user)
    allow_any_instance_of(ApplicationController).
    to receive(:current_user).
    and_return(user)
  end

  def create_one_item_with_one_category
    image = create(:image)
    @item = create(:item, image_id: image.id)
  end

  def add_item_five_times_to_cart
    visit menu_path
    5.times do
      first(:button, "Add to cart").click
    end
  end
end
