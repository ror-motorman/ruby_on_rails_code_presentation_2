class CreateWorkStatistics < ActiveRecord::Migration[5.0]
  def change
    create_table :work_statistics do |t|
      t.belongs_to :user, null: false
      t.belongs_to :project, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at
    end
  end
end
