class User < ActiveRecord::Base
  has_secure_password

  has_many :items
  has_many :orders
  has_many :order_items, through: :orders

  before_validation :generate_slug
  before_save       :downcase_email

  validates :full_name, presence: true, length: { in: 5..100 },
                        format: { with: /\A[a-z ,.\'-]+\z/i, }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :display_name, length: { in: 2..32 }, presence: true,
                           uniqueness: true,
                           format: { with: /\A[a-zA-Z0-9\.\_\-]+\z/, },
                           exclusion: { in: %w(login logout tickets admin venue
                                               venues cart remove_item
                                               update_item events event orders
                                               order),
                             message: "%{value} is reserved." }
  validates :street_1, :city, :state, :zipcode, presence: true
  validates :slug, uniqueness: true


  def admin?
    false
  end

  def generate_slug
    self.slug = display_name.parameterize unless display_name.nil?
  end

  def group_events(cart = nil)
    self.items.active.not_in_cart(cart).group_by { |item| item.event }
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def suspend
    self.items.available.each do |item|
      item.pending = true
      item.save
    end
    self.suspended = true
    self.save
  end

  def unsuspend
    self.items.each do |item|
      item.pending = false
      item.save
    end
    self.suspended = false
    self.save
  end

  private

    def downcase_email
      self.email = self.email.downcase
    end
end
