FactoryGirl.define do
  factory :info, class: Info do
    station1 "川口"
    longitude_latitude1 "35.8019293, 139.71763750000002"
    station2 "さいたま新都心"
    longitude_latitude2 "35.893795, 139.633741"
    route1 "京浜東北線"
    route2 ""
    route3 ""
    route4 ""
    day "1256"
    push_time "10:30"
    push_time2 "19:00"
    line_user_id "xxxxxx"
  end

  factory :valid_info, class: Info  do
    station1 "さいたま新都心"
    longitude_latitude1 ""
    station2 "川口"
    longitude_latitude2 ""
    route1 "京浜東北線"
    route2 ""
    route3 ""
    route4 ""
    day ["1", "2", "5", "6"]
    push_time "10:30"
    push_time2 "19:00"
    line_user_id "xxxxxx"
  end

  factory :invalid_info, class: Info  do
    station1 ""
    longitude_latitude1 ""
    station2 "さいたま新都心"
    longitude_latitude2 ""
    route1 "京浜東北線"
    route2 ""
    route3 ""
    route4 ""
    day ["1", "2", "5", "6"]
    push_time "10:30"
    push_time2 "19:00"
    line_user_id "xxxxxx"
  end
end
