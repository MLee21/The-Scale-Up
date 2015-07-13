class Image < ActiveRecord::Base
  has_many :events

  # has_attached_file :img,
  #   styles: { event_manage_list: "75x75>",
  #             event_banner: "1064x476#",
  #             menu_list: "150x150>",
  #             item_list: "400x400>" }
  # validates_attachment_content_type :img, content_type: /\Aimage\/.*\Z/

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :img, presence: true
end
