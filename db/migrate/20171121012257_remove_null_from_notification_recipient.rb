class RemoveNullFromNotificationRecipient < ActiveRecord::Migration[5.1]
  def change
    change_column :notifications, :recipient_type, :string, null: true
    change_column :notifications, :recipient_id, :string, null: true
  end
end
