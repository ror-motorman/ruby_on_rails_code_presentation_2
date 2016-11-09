class Project < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :users
  has_and_belongs_to_many :accounts
  has_many :work_statistics

  validates_presence_of :name, :account_ids
  validates_uniqueness_of :name

  def available?
    !user_id? && accounts.count(:user_id).zero?
  end
end
