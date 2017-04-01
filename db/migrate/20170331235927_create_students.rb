class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :document
      t.string :email

      t.timestamps
    end
  end
end
