require 'rails_helper'

RSpec.describe Info, type: :model do
  it "is valid " do
    info = build(:info)
    expect(info).to be_valid
  end

  it "is not valid without station1" do
    info = Info.new(station1: "",
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
    expect(info).not_to be_valid
  end

  it "is not valid without longitude_latitude1" do
    info = Info.new(station1: "川口",
                    longitude_latitude1: "",
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
    expect(info).not_to be_valid
  end

  it "is not valid without station2" do
    info = Info.new(station1: "川口",
                    longitude_latitude1: "35.8019293, 139.71763750000002",
                    station2: "",
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
    expect(info).not_to be_valid
  end

  it "is not valid without longitude_latitude2" do
    info = Info.new(station1: "川口",
                    longitude_latitude1: "35.8019293, 139.71763750000002",
                    station2: "さいたま新都心",
                    longitude_latitude2: "",
                    route1:"京浜東北線",
                    route2:"",
                    route3:"",
                    route4:"",
                    day: "1256",
                    push_time: "10:30",
                    push_time2: "19:00",
                    line_user_id: "xxxxxx"
                    )
    expect(info).not_to be_valid
  end

  it "is not valid without route1" do
    info = Info.new(station1: "川口",
                    longitude_latitude1: "35.8019293, 139.71763750000002",
                    station2: "さいたま新都心",
                    longitude_latitude2: "35.893795, 139.633741",
                    route1:"",
                    route2:"",
                    route3:"",
                    route4:"",
                    day: "1256",
                    push_time: "10:30",
                    push_time2: "19:00",
                    line_user_id: "xxxxxx"
                    )
    expect(info).not_to be_valid
  end

  it "is not valid without day" do
    info = Info.new(station1: "川口",
                    longitude_latitude1: "35.8019293, 139.71763750000002",
                    station2: "さいたま新都心",
                    longitude_latitude2: "35.893795, 139.633741",
                    route1:"京浜東北線",
                    route2:"",
                    route3:"",
                    route4:"",
                    day: "",
                    push_time: "10:30",
                    push_time2: "19:00",
                    line_user_id: "xxxxxx"
                    )
    expect(info).not_to be_valid
  end

  it "is not valid without push_time" do
    info = Info.new(station1: "川口",
                    longitude_latitude1: "35.8019293, 139.71763750000002",
                    station2: "さいたま新都心",
                    longitude_latitude2: "35.893795, 139.633741",
                    route1:"京浜東北線",
                    route2:"",
                    route3:"",
                    route4:"",
                    day: "1256",
                    push_time: "",
                    push_time2: "19:00",
                    line_user_id: "xxxxxx"
                    )
    expect(info).not_to be_valid
  end

  it "is not valid without push_time2" do
    info = Info.new(station1: "川口",
                    longitude_latitude1: "35.8019293, 139.71763750000002",
                    station2: "さいたま新都心",
                    longitude_latitude2: "35.893795, 139.633741",
                    route1:"京浜東北線",
                    route2:"",
                    route3:"",
                    route4:"",
                    day: "1256",
                    push_time: "10:30",
                    push_time2: "",
                    line_user_id: "xxxxxx"
                    )
    expect(info).not_to be_valid
  end

  it "is not valid without line_user_id" do
    info = Info.new(station1: "川口",
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
                    line_user_id: ""
                    )
    expect(info).not_to be_valid
  end

end
