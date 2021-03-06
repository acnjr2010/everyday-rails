class AddConfirmableToDeviseV1 < ActiveRecord::Migration[5.0]
  def change
    change_table(:users) do |t|
      t.string   :confirmation_token
      t.datetime :confirmed_at
    end
    add_index  :users, :confirmation_token, :unique => true
  end
end
