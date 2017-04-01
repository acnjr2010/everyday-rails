class AddAcademyIdToStudent < ActiveRecord::Migration[5.0]
  def change
    add_reference :students, :academy, foreign_key: true
  end
end
