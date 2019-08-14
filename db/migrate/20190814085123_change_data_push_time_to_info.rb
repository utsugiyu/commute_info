class ChangeDataPushTimeToInfo < ActiveRecord::Migration[5.2]
  def change
    change_column :infos, :push_time, :string
  end
end
