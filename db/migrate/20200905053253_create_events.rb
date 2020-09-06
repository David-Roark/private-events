class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name_event, null: false
      t.integer :creator_id, null:false
      t.string :promotion, null: false
      t.text :description, null: false
      t.time :time, null: false
      t.date :date, null: false
      t.string :localtion, null: false

      t.timestamps
    end
  end
end
