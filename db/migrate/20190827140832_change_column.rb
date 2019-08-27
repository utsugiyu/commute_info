class ChangeColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :infos, :day, :string, null: false, array: true
  end
end
