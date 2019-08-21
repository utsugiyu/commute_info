class AddColumnPushTime2 < ActiveRecord::Migration[5.2]
  def change
    add_column :infos, :push_time2, :string
  end
end
