class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships, id: :uuid do |t|
      t.uuid :profile_id, null: false
      t.uuid :profile_group_id, null: false

      t.index [:profile_id, :profile_group_id], unique: true

      t.foreign_key :profiles, on_delete: :cascade
      t.foreign_key :profile_groups, on_delete: :cascade
    end
  end
end
