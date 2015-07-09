class Seed
  attr_accessor :categories, :items, :users, :admins, :venues, :events
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
    p "=============================="
    p "Seed data loaded"
    p "=============================="
  end

  def generate_categories
    @categories = Category.create([
      { name: "Sports" },
      { name: "Music" },
      { name: "Theater" },
    ])
  end

  def generate_images
    @images = Image.create([
      { title: "Blazers vs. Nuggets",
        description: "Lillard vs Nuggets",
        img: File.new("#{Rails.root}/app/assets/images/blazers-nuggets.jpg") },
      { title: "Hannibal Burress",
        description: "Hannibal Burress Headshot",
        img: File.new("#{Rails.root}/app/assets/images/hannibal-buress.jpg") },
      { title: "Pitbull and Enrique Iglesias",
        description: "Pitbull and Enrique Being Bosses",
        img: File.new("#{Rails.root}/app/assets/images/pitbull-enrique.jpg") },
      { title: "ABBA!!!",
        description: "The whole gang",
        img: File.new("#{Rails.root}/app/assets/images/abba.jpg") },
      { title: "Portland Timbers",
        description: "The Portland Timbers",
        img: File.new("#{Rails.root}/app/assets/images/timbers.jpg") },
      { title: "Missing",
        description: "crowd",
        img: File.new("#{Rails.root}/app/assets/images/crowd.jpg") }
    ])
  end

  def generate_venues
    @venues = Venue.create([
     { name: "Pepsi Center",
       location: "Denver, CO" },
     { name: "Boulder Theater",
       location: "Boulder, CO" },
     { name: "Madison Square Garden",
       location: "New York, NY" },
     { name: "Providence Park",
       location: "Portland, OR" },
     { name: "Soldier Field",
       location: "Chicago, IL"  },
     { name: "Emirates Stadium",
       location: "London, England" },
    ])
  end

  def generate_events
    @event1 = Event.new(
      title:        "Portland Trailblazers at Denver Nuggets",
      description:  "Come watch the Portland Trailblazer smash the Denver Nuggets.",
      date:         10.days.from_now,
      start_time:   "2000-01-01 16:00:00",
      approved:     true)
    @event1.image      = @images[0]
    @event1.venue      = @venues[0]
    @event1.category   = @categories[0]

    @event2 = Event.new(
      title:        "Hannibal Burress",
      description:  "Come watch funny man Hannibal Burress at the Boulder Theater",
      date:         12.days.from_now,
      start_time:   "2000-01-01 21:00:00",
      approved:     true)
    @event2.image      = @images[1]
    @event2.venue      = @venues[1]
    @event2.category = @categories[2]

    @event3 = Event.new(
      title:        "Pitbull and Enrique Iglesias",
      description:  "The dynamic duo take the stage.",
      date:         22.days.from_now,
      start_time:   "2000-01-01 22:30:00",
      approved:     true)
    @event3.image      = @images[2]
    @event3.venue      = @venues[0]
    @event3.category = @categories[1]

    @event4 = Event.new(
      title:        "Taylor Swift",
      description:  "The dynamic duo take the stage.",
      date:         22.days.ago,
      start_time:   "2000-01-01 20:00:00",
      approved:     true)
    @event4.image      = @images[2]
    @event4.venue      = @venues[0]
    @event4.category = @categories[1]

    @event5 = Event.new(
      title:        "Snoop Dogg",
      description:  "The dynamic duo take the stage.",
      date:         22.days.from_now,
      start_time:   "2000-01-01 22:00:00",
      approved:     false)
    @event5.image      = @images[2]
    @event5.venue      = @venues[0]
    @event5.category = @categories[1]

    @event6 = Event.new(
      title:        "TLC",
      description:  "The dynamic duo take the stage.",
      date:         22.days.from_now,
      start_time:   "2000-01-01 23:00:00",
      approved:     true)
    @event6.image      = @images[2]
    @event6.venue      = @venues[0]
    @event6.category = @categories[1]

    @event7 = Event.new(
      title:        "Johnny Cash",
      description:  "The dynamic duo take the stage.",
      date:         22.days.from_now,
      start_time:   "2000-01-01 22:00:00",
      approved:     true)
    @event7.image      = @images[2]
    @event7.venue      = @venues[0]
    @event7.category = @categories[1]

    @event8 = Event.new(
      title:        "Britney Spears",
      description:  "The dynamic duo take the stage.",
      date:         22.days.from_now,
      start_time:   "2000-01-01 22:30:00",
      approved:     true)
    @event8.image      = @images[2]
    @event8.venue      = @venues[0]
    @event8.category = @categories[1]

    @event9 = Event.new(
      title:        "Reunion Tour: Abba",
      description:  "The old gang is back together",
      date:         40.days.from_now.change({ hour: 1, min: 0, sec: 0  }),
      start_time:   "2000-01-01 19:30:00",
      approved:     true)
    @event9.image      = @images[3]
    @event9.venue      = @venues[2]
    @event9.category = @categories[1]

    @event10 = Event.new(
      title:        "Portland Timbers vs. Colorado Rapids",
      description:  "The beautiful game",
      date:         83.days.from_now.change({ hour: 3, min: 0, sec: 0  }),
      start_time:   "2000-01-01 14:15:00",
      approved:     true)
    @event10.image      = @images[4]
    @event10.venue      = @venues[3]
    @event10.category = @categories[0]

    @event11 = Event.new(
      title:        "Battle Bots",
      description:  "Nerds destroy robots",
      date:         16.days.from_now.change({ hour: 1, min: 0, sec: 0  }),
      start_time:   "2000-01-01 16:00:00",
      approved:     true)
    @event11.image      = @images[-1]
    @event11.venue      = @venues[0]
    @event11.category   = @categories[0]

    @event12 = Event.new(
      title:        "Harry Potter The Musical",
      description:  "Experience the Magic",
      date:         29.days.from_now.change({ hour: 2, min: 0, sec: 0  }),
      start_time:   "2000-01-01 13:00:00",
      approved:     true)
    @event12.image      = @images[-1]
    @event12.venue      = @venues[1]
    @event12.category   = @categories[1]

    @event13 = Event.new(
      title:        "New York Rangers vs. Chicago Blackhawks",
      description:  "Nerds destroy robots",
      date:         78.days.from_now.change({ hour: 3, min: 0, sec: 0  }),
      start_time:   "2000-01-01 18:05:00",
      approved:     true)
    @event13.image      = @images[-1]
    @event13.venue      = @venues[2]
    @event13.category   = @categories[0]

    @event14 = Event.new(
      title:        "Chicago Bears vs. Green Bay Packers",
      description:  "The NFL is in full swing with this epic matchup.",
      date:         90.days.from_now.change({ hour: 2, min: 0, sec: 0  }),
      start_time:   "2000-01-01 11:35:00",
      approved:     true)
    @event14.image      = @images[-1]
    @event14.venue      = @venues[4]
    @event14.category   = @categories[0]

    @event15 = Event.new(
      title:        "The Eagles",
      description:  "The Eagles land in Chicago",
      date:         45.days.from_now.change({ hour: 3, min: 0, sec: 0  }),
      start_time:   "2000-01-01 19:00:00",
      approved:     true)
    @event15.image      = @images[-1]
    @event15.venue      = @venues[4]
    @event15.category   = @categories[1]

    @event16 = Event.new(
      title:        "Chicago Blackhawks vs. Dallas Stars",
      description:  "Hockey at Soldier Field",
      date:         16.days.from_now.change({ hour: 1, min: 0, sec: 0  }),
      start_time:   "2000-01-01 19:00:00",
      approved:     true)
    @event16.image      = @images[-1]
    @event16.venue      = @venues[4]
    @event16.category   = @categories[0]

    @event17 = Event.new(
      title:        "Arsenal vs. Tottenham",
      description:  "The north London Derby",
      date:         100.days.from_now.change({ hour: 2, min: 0, sec: 0  }),
      start_time:   "2000-01-01 19:00:00",
      approved:     true)
    @event17.image      = @images[-1]
    @event17.venue      = @venues[5]
    @event17.category   = @categories[0]

    @event18 = Event.new(
      title:        "Denver Broncos vs Seattle Seahawks",
      description:  "The NFL comes to London",
      date:         89.days.from_now.change({ hour: 1, min: 0, sec: 0  }),
      start_time:   "2000-01-01 19:00:00",
      approved:     true)
    @event18.image      = @images[-1]
    @event18.venue      = @venues[5]
    @event18.category   = @categories[0]

    @event18 = Event.new(
      title:        "Les Miserables",
      description:  "True beauty on the stage",
      date:         45.days.from_now.change({ hour: 1, min: 0, sec: 0  }),
      start_time:   "2000-01-01 19:00:00",
      approved:     true)
    @event18.image      = @images[-1]
    @event18.venue      = @venues[2]
    @event18.category   = @categories[2]

    @event19 = Event.new(
      title:        "CU Buffs vs. CSU Rams",
      description:  "The Rocky Mountain Showdown",
      date:         25.days.from_now.change({ hour: 5, min: 0, sec: 0  }),
      start_time:   "2000-01-01 19:00:00",
      approved:     true)
    @event19.image      = @images[-1]
    @event19.venue      = @venues[1]
    @event19.category   = @categories[0]

    @event20 = Event.new(
      title:        "Shrek The Musical",
      description:  "What a show!",
      date:         33.days.from_now.change({ hour: 5, min: 0, sec: 0  }),
      start_time:   "2000-01-01 19:00:00",
      approved:     true)
    @event20.image      = @images[-1]
    @event20.venue      = @venues[5]
    @event20.category   = @categories[2]

    @event1.save
    @event2.save
    @event3.save
    @event4.save
    @event5.save
    @event6.save
    @event7.save
    @event8.save
    @event9.save
    @event10.save
    @event11.save
    @event12.save
    @event13.save
    @event14.save
    @event15.save
    @event16.save
    @event17.save
    @event18.save
    sleep 2
    @event19.save
    @event20.save
  end

  def generate_users
    50.times do |i|
      user = User.create!(
        full_name: Faker::Name.name,
        email: Faker::Internet.email,
        password:              "password",
        password_confirmation: "password",
        street_1:              Faker::Address.street_address,
        street_2:              Faker::Address.secondary_address,
        city:                  Faker::Address.city,
        state:                 Faker::Address.state,
        zipcode:               Faker::Address.zip_code,
        display_name:          Faker::Internet.user_name
        )
      puts "User #{i}: #{user.display_name} created!"
    end
    @users = User.create!([
      { full_name:             "Rachel Warbelow",
        email:                 "demo+rachel@example.com",
        password:              "password",
        password_confirmation: "password",
        street_1:              "1111 Downing St.",
        street_2:              "Apt. 101",
        city:                  "Denver",
        state:                 "CO",
        zipcode:               80203,
        display_name:          "rwarbelow"},
      { full_name:             "Jeff Casimir",
        email:                 "demo+jeff@example.com",
        password:              "password",
        password_confirmation: "password",
        street_1:              "1111 Downing St.",
        street_2:              "Apt. 101",
        city:                  "Denver",
        state:                 "CO",
        zipcode:               80203,
        display_name:          "j3"},
      { full_name:             "Jorge Tellez",
        email:                 "demo+jorge@example.com",
        password:              "password",
        password_confirmation: "password",
        street_1:              "1111 Downing St.",
        street_2:              "Apt. 101",
        city:                  "Denver",
        state:                 "CO",
        zipcode:               80203,
        display_name:          "novohispano"},
      { full_name:             "Bill Gates",
        email:                 "bill@gates.com",
        password:              "password",
        password_confirmation: "password",
        street_1:              "1111 Downing St.",
        city:                  "Seattle",
        state:                 "WA",
        zipcode:               90329,
        display_name:          "thebillgates"},
      { full_name:             "Taylor Swift",
        email:                 "taytay@swift.com",
        password:              "password",
        password_confirmation: "password",
        street_1:              "1111 Downing St.",
        street_2:              "Apt. 101",
        city:                  "Denver",
        state:                 "CO",
        zipcode:               80203,
        display_name:          "taylorswift13"},
    ])
  end

  def generate_items
    100.times do |i|
      event_offset = rand(Event.count)
      event = Event.offset(event_offset).first

      user_offset = rand(User.count)
      user = User.offset(user_offset).first

      item = Item.create!(
        unit_price:      rand(1000..10000),
        pending:         false,
        sold:            false,
        section:         rand(1..100),
        row:             rand(1..50),
        seat:            rand(1..20),
        delivery_method: "electronic",
        event_id: event.id,
        user_id: user.id,
        ticket: File.new("#{Rails.root}/app/assets/images/fake_ticket.pdf"
        ))
        puts "Item #{i}: #{item.id} created!"
    end

    100.times do |i|
      event_offset = rand(Event.count)
      event = Event.offset(event_offset).first

      user_offset = rand(User.count)
      user = User.offset(user_offset).first

      item = Item.create!(
        unit_price:      rand(1000..10000),
        pending:         false,
        sold:            false,
        section:         rand(1..100),
        row:             rand(1..50),
        seat:            rand(1..20),
        delivery_method: "physical",
        event_id: event.id,
        user_id: user.id
        )
        puts "Item #{i}: #{item.id} created!"
    end

    100.times do |i|
      event_offset = rand(Event.count)
      event = Event.offset(event_offset).first

      user_offset = rand(User.count)
      user = User.offset(user_offset).first

      item = Item.create!(
        unit_price:      rand(1000..10000),
        pending:         false,
        sold:            true,
        section:         rand(1..100),
        row:             rand(1..50),
        seat:            rand(1..20),
        delivery_method: "physical",
        event_id: event.id,
        user_id: user.id,
        )
        puts "Item #{i}: #{item.id} created!"
    end

    @item1 = Item.new(
      unit_price:      3999,
      pending:         false,
      sold:            false,
      section:         220,
      row:             18,
      seat:            "RR",
      delivery_method: "electronic")
    @item1.user  = @users[0]
    @item1.event = @event1

    @item2 = Item.new(
      unit_price:      6924,
      pending:         false,
      sold:            false,
      section:         "BALC II RGT",
      row:             "HH",
      seat:            16,
      delivery_method: "physical")
    @item2.user  = @users[1]
    @item2.event = @event2

    @item3 = Item.new(
      unit_price:      6924,
      pending:         false,
      sold:            false,
      section:         "BALC II RGT",
      row:             "HH",
      seat:            17,
      delivery_method: "physical")
    @item3.user  = @users[1]
    @item3.event = @event2

    @item4 = Item.new(
      unit_price:      6924,
      pending:         false,
      sold:            false,
      section:         "BALC II RGT",
      row:             "HH",
      seat:            18,
      delivery_method: "physical")
    @item4.user  = @users[1]
    @item4.event = @event2

    @item5 = Item.new(
      unit_price:      41705,
      pending:         false,
      sold:            false,
      section:         "Club 212",
      row:             "1",
      seat:            1,
      delivery_method: "electronic")
    @item5.user  = @users[2]
    @item5.event = @event3

    @item6 = Item.new(
      unit_price:      45649,
      pending:         false,
      sold:            false,
      section:         "Loge 128",
      row:             "8",
      seat:            29,
      delivery_method: "physical")
    @item6.user  = @users[2]
    @item6.event = @event3

    @item7 = Item.new(
      unit_price:      45649,
      pending:         false,
      sold:            false,
      section:         "Loge 128",
      row:             "8",
      seat:            29,
      delivery_method: "physical")
    @item7.user  = @users[2]
    @item7.event = @event4

    @item8 = Item.new(
      unit_price:      45649,
      pending:         false,
      sold:            false,
      section:         "Loge 128",
      row:             "8",
      seat:            29,
      delivery_method: "physical")
    @item8.user  = @users[2]
    @item8.event = @event5

    @item9 = Item.new(
      unit_price:      45649,
      pending:         true,
      sold:            false,
      section:         "Loge 128",
      row:             "8",
      seat:            29,
      delivery_method: "physical")
    @item9.user  = @users[2]
    @item9.event = @event6

    @item10 = Item.new(
      unit_price:      45649,
      pending:         false,
      sold:            true,
      section:         "Loge 128",
      row:             "8",
      seat:            29,
      delivery_method: "physical")
    @item10.user  = @users[2]
    @item10.event = @event7

    @item11 = Item.new(
      unit_price:      1958929,
      pending:         false,
      sold:            false,
      section:         "BEST",
      row:             1,
      seat:            56,
      delivery_method: "physical")
    @item11.user  = @users[3]
    @item11.event = @event9

    @item12 = Item.new(
      unit_price:      2999,
      pending:         false,
      sold:            false,
      section:         128,
      row:             8,
      seat:            29,
      delivery_method: "physical")
    @item12.user  = @users[4]
    @item12.event = @event10

    @item1.save
    @item2.save
    @item3.save
    @item4.save
    @item5.save
    @item6.save
    @item7.save
    @item8.save
    @item9.save
    @item10.save
    @item11.save
    @item12.save
  end

  def generate_admins
    Admin.create(full_name:             "Admin",
                 email:                 "admin@admin.com",
                 password_confirmation: "password",
                 password:              "password")
    Admin.create(full_name:             "Josh Cheek",
                 email:                 "demo+josh@example.com",
                 password_confirmation: "password",
                 display_name:          "josh")
  end

  def generate_orders
    100.times do |i|
      user = User.find(rand(20) + 1)
      order = Order.create!(user_id: user.id, status: "ordered")
      @item = Item.new(
      unit_price:      rand(2999) + 10,
      pending:         false,
      sold:            false,
      section:         128,
      row:             8,
      seat:            29,
      delivery_method: "physical")

      puts "#{i} Order #{order.id}: Order for #{user.full_name} created!"
    end

    5.times do |i|
      order = Order.create!(user_id: 3, status: "ordered")
      add_items(order)
    end
  end

  private

  def add_items(order)
    5.times do |i|
      item = Item.find(rand(20) + 1)
      OrderItem.create(item_id: item.id, order_id: order.id)
    end
  end
end

Seed.new
