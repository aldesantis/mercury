class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications, id: :uuid do |t|
      t.string :recipient_type, null: false
      t.uuid :recipient_id, null: false
      t.string :text, null: false
      t.json :meta, null: false, default: '{}'

      t.timestamps null: false

      t.index [:recipient_type, :recipient_id]
    end
  end
end
