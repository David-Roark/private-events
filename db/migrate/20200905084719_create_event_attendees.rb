class CreateEventAttendees < ActiveRecord::Migration[6.0]
  def change
    create_table :event_attendees do |t|
      t.integer :event_id, null: false
      t.integer :attendee_id, null:false

      t.timestamps
    end
  end
end
