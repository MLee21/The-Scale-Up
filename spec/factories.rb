FactoryGirl.define do

  sequence :name do |n|
    "name#{n}"
  end

  sequence :title do |n|
    "title#{n}"
  end

  sequence :display_name do |n|
    "display#{n}"
  end

  sequence :email do |n|
    "email#{n}@gmail.com"
  end

  factory :admin do
    full_name "Yolo Ono"
    email "admin@admin.com"
    password "password"
    display_name "Admin"
  end

  factory :user do
    full_name "John Bob Smith"
    email
    password "test"
    password_confirmation "test"
    street_1 "2345 Lake Rd"
    city "Portland"
    state "OR"
    zipcode 97222
    display_name
  end

  factory :image do
    title
    description "Red Rocks"
    img File.new("#{Rails.root}/app/assets/images/red-rocks.jpg")
  end

  factory :item do
    pending false
    unit_price 500
    section "1"
    row "1"
    seat "1"
    delivery_method 'electronic'
    user
    event
  end

  factory :category do
    name
  end

  factory :venue do
    name
    location "21 Jump Street, Denver, CO"
  end

  factory :event do
    title
    date { 15.days.from_now }
    start_time Time.now
    approved true

    before(:create) do |event|
      event.image = create(:image)
      event.venue = create(:venue)
      event.category = create(:category)
      event.save
    end
  end
end
