class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :forename
      t.string :surname
      t.string :email

      t.timestamps
    end
  end
end
