class Account < ApplicationRecord
  belongs_to :service
  belongs_to :user
  has_and_belongs_to_many :projects

  validates_presence_of :service_id, :name, :url, :login, :password
  validates_uniqueness_of :name
end
