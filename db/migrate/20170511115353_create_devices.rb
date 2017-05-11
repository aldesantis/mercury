class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices, id: :uuid do |t|
      t.uuid :profile_id, null: false
      t.string :type, null: false
      t.json :source, null: false, default: {}

      t.timestamps null: false

      t.foreign_key :profiles, on_delete: :cascade
    end
  end
end
