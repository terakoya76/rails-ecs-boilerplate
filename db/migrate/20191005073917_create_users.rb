class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, bulk: true do |t|
      t.integer :age, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.timestamps
    end
  end
end
