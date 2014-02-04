class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :user_id, presence: true

  scope :desc, -> { order(created_at: :desc) }

  mount_uploader :image, ImageUploader
  acts_as_taggable

  self.per_page = 7
end
