class Service < ApplicationRecord
  has_many :accounts, dependent: :destroy

  validates_presence_of :name, :url, :login_button_identifier, :login_field_identifier
  validates_uniqueness_of :name, :url
end
