class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.belongs_to :service
      t.belongs_to :user
      t.string :name, null: false
      t.string :url, null: false
      t.string :login, null: false
      t.string :password, null: false
      t.text :note

      t.timestamps
    end
  end
end
