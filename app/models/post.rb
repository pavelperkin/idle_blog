class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  after_create :set_moderated
  validates :user_id, presence: true
  

  scope :desc, -> { order(created_at: :desc) }
  scope :moderated, -> { where(moderated: true) }
  scope :waiting_for_moderation, -> { where(moderated: false) }

  mount_uploader :image, ImageUploader
  acts_as_taggable

  self.per_page = 7

  def set_moderated
    self.update_attributes moderated: moderation_not_required?
  end

  private

  def moderation_not_required?
    self.user.admin? || self.user.trusted?
  end
end
