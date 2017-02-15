class CreateTalks < ActiveRecord::Migration[5.0]
  def change
    create_table :talks do |t|
      t.string :speaker_name
      t.string :title
      t.datetime :start_time
      t.datetime :end_time
      t.references :conference, foreign_key: true

      t.timestamps
    end
  end
end
