class WorkStatistic < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates_presence_of :user, :project, :start_at

  before_validation :set_start_at, on: :create

  private

  def set_start_at
    self.start_at = Time.zone.now
  end
end
