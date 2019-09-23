require 'test_helper'

class InfoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "shoud be valid" do
    @info = Info.new(station1: "川口",
                    longitude_latitude1: "35.8019293, 139.71763750000002",
                    station2: "さいたま新都心",
                    longitude_latitude2: "35.893795, 139.633741",
                    route1:"京浜東北線",
                    route2:"",
                    route3:"",
                    route4:"",
                    day: "1256",
                    push_time: "10:30",
                    push_time2: "19:00",
                    line_user_id: "xxxxxx"
                    )
    assert @info.valid?
  end

  test "should be invalid" do
    @info = Info.new(station1: "",
                    longitude_latitude1: "35.8019293, 139.71763750000002",
                    station2: "さいたま新都心",
                    longitude_latitude2: "35.893795, 139.633741",
                    route1:"京浜東北線",
                    route2:"",
                    route3:"",
                    route4:"",
                    day: "1256",
                    push_time: "1030",
                    push_time2: "19:00",
                    line_user_id: "xxxxxx"
                    )
    assert_not @info.valid?
  end
end
