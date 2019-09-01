namespace :info do
  desc "該当日時の登録情報があれば気温、降水確率、運行情報を取得して通知する"
  task get_info1: :environment do
    day = Time.zone.now.wday.to_s
    time = Time.zone.now.strftime("%H:%M")
    datas_count = 24 - Time.zone.now.hour - 1
    infos = Info.where("day LIKE ? AND push_time LIKE ?", "%#{day}%", "%#{time}%")

    if infos
      infos.each do |info|

        params1 = URI.encode_www_form({ exclude: 'minutely,daily,alerts,flags', lang: 'ja' , units: 'si' })
        uri1 = URI.parse("https://api.darksky.net/forecast/#{ENV['DARK_SKY_KEY']}/#{info.longitude_latitude1}?#{params1}")

        http1 = Net::HTTP.new(uri1.host, uri1.port)
        http1.use_ssl = true
        http1.verify_mode = OpenSSL::SSL::VERIFY_NONE

        req1 = Net::HTTP::Get.new (uri1.request_uri)
        res1 = http1.request(req1)
        weather_res1 = JSON.parse(res1.body)


        params2 = URI.encode_www_form({ exclude: 'minutely,daily,alerts,flags', lang: 'ja' , units: 'si' })
        uri2 = URI.parse("https://api.darksky.net/forecast/#{ENV['DARK_SKY_KEY']}/#{info.longitude_latitude2}?#{params2}")

        http2 = Net::HTTP.new(uri2.host, uri2.port)
        http2.use_ssl = true
        http2.verify_mode = OpenSSL::SSL::VERIFY_NONE

        req2 = Net::HTTP::Get.new (uri2.request_uri)
        res2 = http2.request(req2)
        weather_res2 = JSON.parse(res2.body)

        temps = []
        probs = []

        for i in 0..datas_count do
          temps << weather_res1["hourly"]["data"][i]["temperature"]
          temps << weather_res2["hourly"]["data"][i]["temperature"]
          probs << weather_res1["hourly"]["data"][i]["precipProbability"]
          probs << weather_res2["hourly"]["data"][i]["precipProbability"]
        end

        #通知する最高気温と最高降水確率
        push_temp = temps.max.round.to_s
        push_prob = (probs.max * 100).round.to_s

        #ここからは運行情報の取得
        uri3 = URI.parse("https://tetsudo.rti-giken.jp/free/delay.json")

        http3 = Net::HTTP.new(uri3.host, uri3.port)
        http3.use_ssl = true
        http3.verify_mode = OpenSSL::SSL::VERIFY_NONE

        req3 = Net::HTTP::Get.new (uri3.request_uri)
        res3 = http3.request(req3)
        delay_res = JSON.parse(res3.body)

        delays = []

        delay_res.each do |delay|
          route1_array = info.route1.split(",")
          route1_name = route1_array[0]
          route1_company = route1_array[1]

          if delay["name"].include?(route1_name) && delay["company"].include?(route1_company)
            delays << "#{delay["name"]}(#{delay["company"]})"
          end

          if !info.route2.empty?
            route2_array = info.route2.split(",")
            route2_name = route2_array[0]
            route2_company = route2_array[1]
            if delay["name"].include?(route2_name) && delay["company"].include?(route2_company)
              delays << "#{delay["name"]}(#{delay["company"]})"
            end

            if !info.route3.empty?
              route3_array = info.route3.split(",")
              route3_name = route3_array[0]
              route3_company = route3_array[1]
              if delay["name"].include?(route3_name) && delay["company"].include?(route3_company)
                delays << "#{delay["name"]}(#{delay["company"]})"
              end

              if !info.route4.empty?
                route4_array = info.route4.split(",")
                route4_name = route4_array[0]
                route4_company = route4_array[1]
                if delay["name"].include?(route4_name) && delay["company"].include?(route4_company)
                  delays << "#{delay["name"]}(#{delay["company"]})"
                end
              end #route4
            end#route3
          end #route2
        end #each

        if delays.empty?
          delay_mes = "使用路線に遅延情報はありません。"
        else
          delays_joined = delays.join(', ')
          delay_mes = "#{delays_joined}が遅延しています。"
        end

        message = {
          type: 'text',
          text: "#{info.station1} <=> #{info.station2}の通勤情報(行き)\n\n《最高気温》\n#{push_temp}°C\n\n《最高降水確率》\n#{push_prob}％\n\n《運行情報》\n#{delay_mes}"
        }
        client = Line::Bot::Client.new { |config|
          config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
          config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
        }
        response = client.push_message(info.line_user_id, message)
        p response
      end #大枠のeach
    end #if infos
  end #タスク

  desc "該当日時の登録情報があれば運行情報を取得して通知する"
  task get_info2: :environment do
    day = Time.zone.now.wday.to_s
    time = Time.zone.now.strftime("%H:%M")
    infos = Info.where("day LIKE ? AND push_time2 LIKE ?", "%#{day}%", "%#{time}%")

    if infos
      infos.each do |info|
        uri4 = URI.parse("https://tetsudo.rti-giken.jp/free/delay.json")

        http4 = Net::HTTP.new(uri4.host, uri4.port)
        http4.use_ssl = true
        http4.verify_mode = OpenSSL::SSL::VERIFY_NONE

        req4 = Net::HTTP::Get.new (uri4.request_uri)
        res4 = http4.request(req4)
        delay_res = JSON.parse(res4.body)

        delays = []

        delay_res.each do |delay|
          route1_array = info.route1.split(",")
          route1_name = route1_array[0]
          route1_company = route1_array[1]

          if delay["name"].include?(route1_name) && delay["company"].include?(route1_company)
            delays << "#{delay["name"]}(#{delay["company"]})"
          end

          if !info.route2.empty?
            route2_array = info.route2.split(",")
            route2_name = route2_array[0]
            route2_company = route2_array[1]
            if delay["name"].include?(route2_name) && delay["company"].include?(route2_company)
              delays << "#{delay["name"]}(#{delay["company"]})"
            end

            if !info.route3.empty?
              route3_array = info.route3.split(",")
              route3_name = route3_array[0]
              route3_company = route3_array[1]
              if delay["name"].include?(route3_name) && delay["company"].include?(route3_company)
                delays << "#{delay["name"]}(#{delay["company"]})"
              end

              if !info.route4.empty?
                route4_array = info.route4.split(",")
                route4_name = route4_array[0]
                route4_company = route4_array[1]
                if delay["name"].include?(route4_name) && delay["company"].include?(route4_company)
                  delays << "#{delay["name"]}(#{delay["company"]})"
                end
              end #route4
            end#route3
          end #route2
        end #each

        if delays.empty?
          delay_mes = "使用路線に遅延情報はありません。"
        else
          delays_joined = delays.join(', ')
          delay_mes = "#{delays_joined}が遅延しています。"
        end

        message = {
          type: 'text',
          text: "#{info.station1} <=> #{info.station2}の通勤情報(帰り)\n\n《運行情報》\n#{delay_mes}"
        }
        client = Line::Bot::Client.new { |config|
          config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
          config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
        }
        response = client.push_message(info.line_user_id, message)
        p response
      end
    end
  end

end
