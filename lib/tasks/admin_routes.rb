class AdminRoutes

  attr_reader :session, :root

  def initialize(session, root)
    @session = session
    @root = root
    all
  end

  def all
    puts "visiting admin paths"
    login_admin
    orders 
    categories
    events 
    venues
    items
    logout_admin
  end

  def login_admin
    puts "logging in admin"
    session.click_link("Login")
    session.fill_in 'session[email]', with: admin_user.email
    session.fill_in 'session[password]', with: 'password'
    session.click_button('Log in')
  end

  def logout_admin
    session.visit "#{root}"
    session.click_link_or_button('Logout')
  end

  def orders
    puts "visiting admin orders"
    session.visit "#{root}/admin/orders/ordered"
    session.within('.event-tickets tr:nth-child(3)') do 
      session.click_link_or_button('Cancel Order')     
    end
    puts "order cancelled"
    session.visit "#{root}/admin/orders/new"
    session.visit "#{root}/admin/orders/ordered"
  end

  def categories
    puts "visiting admin categories"
    session.visit "#{root}/admin/categories"
    session.visit "#{root}/admin/categories/1"
    session.visit "#{root}/admin/categories/1/edit"
    session.visit "#{root}/admin/categories/1/new"
  end

  def events
    puts "visiting admin events"
    session.visit "#{root}/admin/events"
    session.visit "#{root}/admin/events/1/edit"
    session.visit "#{root}/admin/events/new"
  end

  def venues
    puts "visiting admin venues"
    session.visit "#{root}/admin/venues"
    session.visit "#{root}/admin/venues/1/edit"
    session.visit "#{root}/admin/venues/new"
  end

  def items
    puts "visiting admin items"
    # session.visit "#{root}/admin/items"
    # session.visit "#{root}/admin/items/1"
    # session.visit "#{root}/admin/items/1/edit"
    # session.visit "#{root}/admin/items/new"
  end

  def admin_user
    admin ||= Admin.find(1)
  end

end