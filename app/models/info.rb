class Info < ApplicationRecord
  validates :station1, presence: true
  validates :longitude_latitude1, presence: true
  validates :station2, presence: true
  validates :longitude_latitude2, presence: true
  validates :route1, presence: true
  validates :day, presence: true
  validates :push_time, presence: true
  validates :push_time2, presence: true
  validates :line_user_id, presence: true


end
