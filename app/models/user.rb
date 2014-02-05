class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :authentication_keys => [:login]

  before_create :create_role

  has_many :posts
  has_many :comments
  has_many :users_roles
  has_many :roles, :through => :users_roles

  attr_accessor :login

  validates :username, uniqueness: { case_sensitive: false }, presence: true

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def admin?
    self.roles.map(&:name).include? 'admin'
  end

  def author?
    self.roles.map(&:name).include? 'author'
  end

  def reader?
    self.roles.map(&:name).include? 'reader'
  end

  def trusted?
    self.roles.map(&:name).include? 'trusted'
  end

  private

    def create_role
      self.roles << Role.find_by_name(:reader)
    end
end
