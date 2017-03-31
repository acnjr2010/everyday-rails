class CreateAcademies < ActiveRecord::Migration[5.0]
  def change
    create_table :academies do |t|
      t.string :academy_name
      t.string :director_name
      t.string :address
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
