class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :resource_type
      t.integer :resource_id

      t.timestamps
    end
  end
end
