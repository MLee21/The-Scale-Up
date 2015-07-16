require 'capybara/poltergeist'
require_relative './admin_routes'

class LoadScript
  include Capybara::DSL
  attr_reader :root
  def initialize(server_url)
    @root = server_url
    login
  end

  def session
    @session ||= Capybara::Session.new(:poltergeist)
  end

  def run
    100.times do
      send(actions.sample)
    end    
    complete
  end

  def actions
    [:home, :tickets, :event_details, :cart, :orders, 
     :order_details, :account_details, :store,
     :create_ticket, :create_account, :admin_routes]
  end

  def login
    puts "logging in"
    home
    if session.has_content?('Logout')
      logout
      login
    else
      session.click_link_or_button("Login")
      session.fill_in 'session[email]', with: real_user.email
      session.fill_in 'session[password]', with: 'password'
      session.click_button('Log in')
    end
  end

  def home
    puts "viewing the home page"
    session.visit "#{root}"
  end

  def tickets
    puts "viewing tickets"
    session.visit "#{root}/tickets"
    session.all('.filter-button').sample.click
    # puts "viewing sports tickets"
    # session.click_link("Sports")
    # puts "viewing music tickets"
    # session.click_link("Music")
    # puts "viewing theater tickets"
    # session.click_link("Theater")
    # puts "viewing all tickets"
    # session.click_link("All")
  end

  def event_details
    puts "viewing event details"
    session.visit "#{root}/events/#{number_of_events}"
  end

  def cart
    puts "viewing user cart"
    session.visit "#{root}/cart"
    session.click_link("Search Tickets")
  end

  def orders
    puts "viewing user orders"
    session.visit "#{root}/#{real_user.slug}/orders"
  end

  def order_details
    if real_user_orders.count > 0
      puts "viewing order details"
      session.visit "#{root}/#{real_user.slug}/orders/#{real_user_orders.first.id}"
    end
  end

  def account_details
    puts "viewing user account"
    session.visit "#{root}/#{real_user.slug}/dashboard"
  end

  def store
    puts "viewing store"
    session.visit "#{root}/#{real_user.slug}/store"
  end

  def logout
    home
    puts "logging out"
    session.click_link('Logout')
  end

  def create_account
    session.visit "#{root}/users/new"
    session.fill_in "user[full_name]", with: "Kristina B"
    session.fill_in "user[display_name]", with: ("A".."Z").to_a.shuffle.first(2).join
    session.fill_in "user[email]", with: (1..20).to_a.shuffle.join + "@sample.com"
    session.fill_in "user[street_1]", with: "main st"
    session.fill_in "user[city]", with: "Portland"
    session.select  "Oregon", from: "user[state]"
    session.fill_in "user[zipcode]", with: "97215"
    session.fill_in "user[password]", with: "password"
    session.fill_in "user[password_confirmation]", with: "password"
    session.click_button("Create my account!")
    puts "user account created"
  end

  def create_ticket
    session.visit "#{root}/tickets/new"
    session.click_link("My Hubstub")
    session.click_link("List a Ticket")
    session.select  "test", from: "item[event_id]"
    session.fill_in "item[section]", with: "FA"
    session.fill_in "item[row]", with: "555"
    session.fill_in "item[seat]", with: "60"
    session.fill_in "item[unit_price]", with: 30
    session.select  "Electronic", from: "item[delivery_method]"
    session.click_button("List Ticket")
    puts "New ticket created"
  end

  def admin_routes
    home
    logout
    AdminRoutes.new(session, root)
    puts "admin logged out"
    login
  end

  def complete
    puts "script complete"
  end

  def real_user
    user ||= User.find(rand(1..20))
  end

  def real_user_orders
    orders ||= real_user.orders
  end

  def number_of_events
    total ||= Event.count
    rand(total)
  end

end

namespace :load_script do
  desc "Run a simple load script against your server"
  task :run => :environment do
    ENV['url'] == 'dev' ? (url = 'http://localhost:3000/') : (url = 'https://the-scale-up.herokuapp.com/') 
    # 5.times.map { Thread.new { LoadScript.new(url).run } }.map(&:join)
    LoadScript.new(url).run
  end
end