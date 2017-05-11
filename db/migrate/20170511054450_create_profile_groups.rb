class CreateProfileGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :profile_groups, id: :uuid do |t|
      t.string :name, null: false
    end

    add_index :profile_groups, :name, unique: true
  end
end
