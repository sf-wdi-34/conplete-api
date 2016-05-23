class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.string :title
      t.string :speaker_name
      t.datetime :start_time
      t.datetime :end_time
      t.belongs_to :conference, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
