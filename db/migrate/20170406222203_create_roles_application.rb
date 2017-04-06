class CreateRolesApplication < ActiveRecord::Migration[5.0]
  def up
    ['Admin', 'Editor', 'Author', 'Member', 'Guest'].each do |role_name|
      Role.create!(name: role_name)
    end
  end

  def down
    Role.where(name: ['Admin', 'Editor', 'Author', 'Member', 'Guest']).destroy_all
  end
end
