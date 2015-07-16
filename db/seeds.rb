require 'populator'
require 'faker'
require 'bcrypt'

class Seed
  attr_accessor :categories, :items, :users, :admins, :venues, :events
  
  include BCrypt

  def initialize
    p "=============================="
    p "Seeding started"
    p "=============================="
    generate_categories
    generate_images
    generate_venues
    generate_events
    generate_users
    generate_items
    generate_admins
    generate_orders
    generate_order_items
    p "=============================="
    p "Seed data loaded"
    p "=============================="
  end

  def generate_categories
    @categories = Category.create([
      { name: "Sports" },
      { name: "Music" },
      { name: "Theater" }
    ])
    Category.populate(12) do |category|
      category.name = Faker::Lorem.word
    end
    puts "15 categories generated"
  end

  def generate_images
    count = 0
    Image.populate(500) do |image|
      image.title = Faker::Lorem.word
      image.description = Faker::Lorem.sentence
      image.img_file_name = "blazers-nuggets.jpg" 
      image.img_file_size = 103302 
      image.img_content_type = "image/jpeg"
      puts "image #{count += 1} created"
    end
    puts "500,000 images generated"
  end

  def generate_venues
    count = 0
    Venue.populate(500) do |venue|
      venue.name = Faker::Commerce.department
      venue.location = "#{Faker::Address.city}, #{Faker::Address.state_abbr}"
      puts "venue #{count += 1} created"
    end
    puts "500,000 venues generated"
  end

  def generate_events
    Event.create!(title: "test", description: "test", date: Time.now, start_time: Time.now, approved: true, image_id: 1, venue_id: 1, category_id: 1)
    count = 0
    images = Image.count
    venues = Venue.count
    categories = Category.count
    Event.populate(500) do |event|
      event.title = Faker::Lorem.word
      event.description = Faker::Lorem.sentence
      date = Faker::Date.between(65.days.ago, 300.days.from_now)
      event.date = date
      event.start_time = "#{date} 16:00:00"
      event.approved = [ true, false ]
      event.image_id = rand(1..images)
      event.venue_id = rand(1..venues)
      event.category_id = rand(1..categories)
      puts "event #{count += 1} created"
    end
    puts "500,000 events generated"
  end

  def generate_users
    count = 0
    20.times do
      User.create!(
        full_name: Faker::Name.name,
        email: "#{Faker::Lorem.characters(10)}#{Faker::Internet.email}",
        password: 'password', 
        password_confirmation: 'password', 
        street_1: Faker::Address.street_address,
        street_2: Faker::Address.secondary_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        zipcode: 80226,
        display_name: "#{Faker::Lorem.characters(47)}#{rand(100..999)}"
      )
      puts "user #{count += 1} created"
    end
    User.populate(100) do |user|
      user.full_name = Faker::Name.name
      user.email = "#{Faker::Lorem.characters(10)}#{Faker::Internet.email}"
      user.password_digest = 'password' #BCrypt::Password.create('password')
      user.street_1 = Faker::Address.street_address
      user.street_2 = Faker::Address.secondary_address
      user.city = Faker::Address.city
      user.state = Faker::Address.state
      user.zipcode = 80226
      user.slug = "#{Faker::Lorem.characters(47)}#{rand(100..999)}"
      puts "user #{count += 1} created"
    end
    puts "200,000 users generated"
  end 

  def generate_items
    count = 0
    events = Event.count
    users  = (User.count / 6).to_i
    puts "#{users} sellers"
    Item.populate(500) do |item|
      item.unit_price = rand(1000..10000)
      item.pending = [ true, false ]
      item.sold = [ true, false ]
      item.section = rand(1..100)
      item.row = rand(1..50)
      item.seat = rand(1..20)
      item.delivery_method = [ "electronic", "physical" ]
      item.event_id = rand(1..events)
      item.user_id = rand(1..users)
      item.ticket_file_name = "fake_ticket.pdf" 
      item.ticket_content_type = "application/pdf"
      item.ticket_file_size = 258297
      puts "item #{count += 1} created"
    end
    puts "500,000 items generated"
  end

  def generate_admins
    Admin.create(full_name:             "Admin",
                 email:                 "admin@admin.com",
                 password_confirmation: "password",
                 password:              "password")
    puts "1 admin generated"
  end

  def generate_orders
    count = 0
    users = User.count
    Order.populate(500) do |order|
      order.status = "ordered"
      order.user_id = rand(1..users) 
      order.total_price = rand(1000..100000)
      puts "order #{count += 1} created"
    end
    puts "50,000 orders generated"
  end

  def generate_order_items
    count = 0
    orders = Order.count
    items = Item.count
    OrderItem.populate(500) do |order_item|
      order_item.order_id = rand(1..orders)
      order_item.item_id = rand(1..items)
      puts "order item #{count += 1} created"
    end
    puts "500,000 order items generated"
  end

end

Seed.new