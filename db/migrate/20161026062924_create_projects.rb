class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.belongs_to :user
      t.string :name, null: false
      t.boolean :banned, default: false

      t.timestamps
    end
  end
end
