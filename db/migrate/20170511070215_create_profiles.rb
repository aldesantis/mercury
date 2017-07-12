class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles, id: :uuid do |t|
      t.string :name, null: false
      t.timestamps null: false
    end

    add_index :profiles, :name, unique: true
  end
end
