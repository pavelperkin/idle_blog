class Post < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true

  scope :desc, -> { order(created_at: :desc) }

  self.per_page = 7
end
