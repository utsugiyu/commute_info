class CreateInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :infos do |t|
      t.string :station1, null: false
      t.string :longitude_latitude1, null: false
      t.string :station2, null: false
      t.string :longitude_latitude2, null: false
      t.string :route1, null: false
      t.string :route2
      t.string :route3
      t.string :route4
      t.string :day, null: false
      t.datetime :push_time, null: false
      t.string :line_user_id, null: false

      t.timestamps
    end
  end
end
