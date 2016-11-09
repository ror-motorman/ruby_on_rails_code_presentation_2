class User < ApplicationRecord
  ROLES = %i(admin user).freeze

  has_many :accounts
  has_many :occupied_projects, foreign_key: :user_id, class_name: 'Project', dependent: :nullify
  has_many :work_statistics
  has_and_belongs_to_many :projects

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: %i(login)

  enum role: ROLES

  validates_presence_of :full_name, :login, :origin_password, :position, :role
  validates_length_of :origin_password, minimum: 8, allow_blank: true
  validates_uniqueness_of :login

  after_initialize :set_role, unless: :role
  before_validation :set_password

  def projects
    admin? ? Project.all : super
  end

  private

  def set_password
    if origin_password_changed?
      self.password = origin_password
    elsif password
      self.origin_password = password
    end
  end

  def set_role
    self.role = 'user'
  end
end
