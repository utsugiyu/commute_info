class InfosController < ApplicationController
  before_action :has_param_line_user_id_param, only: [:new, :index]
  before_action :access_from_index, only: [:edit]
  before_action :invalid_access1, only: [:destroy]
  before_action :invalid_access2, only: [:create]
  before_action :invalid_access3, only: [:update]


  def new
    @info = Info.new
    lines
  end

  def create
    lines
    @info = Info.new(info_params)

    if !params[:info][:day].nil?
      @info.day = params[:info][:day].join
    end

    if @info.station1.empty?
    elsif !@info.station1.empty? && !@info.station1.include?("駅")
      @info.station1 << "駅"
      results1 = Geocoder.search(@info.station1)
    else
      results1 = Geocoder.search(@info.station1)
    end

    if @info.station1.empty?
    elsif !@info.station1.empty? && results1.first.nil?
      #longエラー
    elsif !@info.station1.empty? && !results1.first.nil?
      @info.longitude_latitude1 = results1.first.coordinates.join(',')
    end


    if @info.station2.empty?
    elsif !@info.station2.empty? && !@info.station2.include?("駅")
      @info.station2 << "駅"
      results2 = Geocoder.search(@info.station1)
    else
      results2 = Geocoder.search(@info.station1)
    end

    if @info.station2.empty?
    elsif !@info.station2.empty? && results2.first.nil?
      #longエラー
    elsif !@info.station2.empty? && !results2.first.nil?
      @info.longitude_latitude2 = results2.first.coordinates.join(',')
    end

    if @info.save
      flash[:info] = "情報の登録が完了しました"
      redirect_to "/?line_user_id=#{@info.line_user_id}"
    else
      render 'new'
    end
  end

  def index
    has_param_line_user_id_param
    @infos = Info.where(line_user_id: params[:line_user_id])
  end

  def edit
    @info = Info.find(params[:id])
    @line_user_id = @info.line_user_id
    lines
  end

  def update
    lines
    @info = Info.find_by(id: params[:id])
    @line_user_id = @info.line_user_id
    @info.assign_attributes(info_params)

    if @info.station1.empty?
    elsif !@info.station1.empty? && !@info.station1.include?("駅")
      @info.station1 << "駅"
      results1 = Geocoder.search(@info.station1)
    else
      results1 = Geocoder.search(@info.station1)
    end

    if @info.station1.empty?
    elsif !@info.station1.empty? && results1.first.nil?
      #longエラー
      @info.longitude_latitude1 = nil
    elsif !@info.station1.empty? && !results1.first.nil?
      @info.longitude_latitude1 = results1.first.coordinates.join(',')
    end


    if @info.station2.empty?
    elsif !@info.station2.empty? && !@info.station2.include?("駅")
      @info.station2 << "駅"
      results2 = Geocoder.search(@info.station1)
    else
      results2 = Geocoder.search(@info.station1)
    end

    if @info.station2.empty?
    elsif !@info.station2.empty? && results2.first.nil?
      #longエラー
      @info.longitude_latitude2 = nil
    elsif !@info.station2.empty? && !results2.first.nil?
      @info.longitude_latitude2 = results2.first.coordinates.join(',')
    end

    if params[:info][:day].nil?
      @info.day = nil
    elsif !params[:info][:day].nil?
      @info.day = params[:info][:day].join
    end

    if @info.save
      flash[:success] = "情報が更新されました。"
      redirect_to "/index?line_user_id=#{@info.line_user_id}"
    else
      render "edit"
    end
  end

  def destroy
    @info = Info.find(params[:id])
    line_user_id = @info.line_user_id
    @info.destroy
    flash[:info] = "情報が削除されました。"
    redirect_to("/index?line_user_id=#{line_user_id}")
  end

  def callback
  body = request.body.read

  signature = request.env['HTTP_X_LINE_SIGNATURE']
  unless client.validate_signature(body, signature)
    head :bad_request
  end

  events = client.parse_events_from(body)

  secret = ENV['SECRET']
  iv = ENV['IV']

  events.each { |event|
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        if event.message['text'].include?('登録')
          source_line_user_id = event['source']['userId']
          @line_user_id = Base64.urlsafe_encode64(Encryptor.encrypt(value: source_line_user_id, key: secret, iv: iv)).encode('utf-8')
          client.reply_message(event['replyToken'], template)
        elsif event.message['text'].include?('削除') || event.message['text'].include?('編集')
          source_line_user_id = event['source']['userId']
          @line_user_id = Base64.urlsafe_encode64(Encryptor.encrypt(value: source_line_user_id, key: secret, iv: iv)).encode('utf-8')
          client.reply_message(event['replyToken'], template2)
        end
      end
    end
  }

  head :ok
  end

  def access
  end

  private

    def lines
      @lines = [
      ["五日市線(JR東日本)", "五日市線,JR東日本"],
      ["上野東京ライン(JR東日本)", "上野東京ライン,JR東日本"],
      ["宇都宮線(JR東日本)", "宇都宮線,JR東日本"],
      ["青梅線(JR東日本)", "青梅線,JR東日本"],
      ["京浜東北線(JR東日本)", "京浜東北線,JR東日本"],
      ["京葉線(JR東日本)", "京葉線,JR東日本"],
      ["埼京線(JR東日本)", "埼京線,JR東日本"],
      ["相模線(JR東日本)", "相模線,JR東日本"],
      ["湘南新宿ライン(JR東日本)", "湘南新宿ライン,JR東日本"],
      ["常磐線(JR東日本)", "常磐線,JR東日本"],
      ["総武線・総武本線(JR東日本)", "総武,JR東日本"],
      ["高崎線(JR東日本)", "高崎線,JR東日本"],
      ["中央線・中央本線(JR東日本)", "中央,JR東日本"],
      ["東北本線(JR東日本)", "東北本線,JR東日本"],
      ["東海道本線(JR東海)", "東海道本線,JR東海"],
      ["南武線(JR東日本)", "南武線,JR東日本"],
      ["八高線(JR東日本)", "八高線,JR東日本"],
      ["武蔵野線(JR東日本)", "武蔵野線,JR東日本"],
      ["山手線(JR東日本)", "山手線,JR東日本"],
      ["横須賀線(JR東日本)", "横須賀線,JR東日本"],
      ["横浜線(JR東日本)", "横浜線,JR東日本"],
      ["銀座線(東京メトロ)", "銀座線,東京メトロ"],
      ["埼玉高速鉄道線(東京メトロ)", "埼玉高速鉄道線,東京メトロ"],
      ["千代田線(東京メトロ)", "千代田線,東京メトロ"],
      ["東西線(東京メトロ)", "東西線,東京メトロ"],
      ["南北線(東京メトロ)", "南北線,東京メトロ"],
      ["半蔵門線(東京メトロ)", "半蔵門線,東京メトロ"],
      ["日比谷線(東京メトロ)", "日比谷線,東京メトロ"],
      ["副都心線(東京メトロ)", "副都心線,東京メトロ"],
      ["丸ノ内線(東京メトロ)", "丸ノ内線,東京メトロ"],
      ["有楽町線(東京メトロ)", "有楽町線,東京メトロ"],
      ["浅草線(都営地下鉄)", "浅草線,都営地下鉄"],
      ["大江戸線(都営地下鉄)", "大江戸線,都営地下鉄"],
      ["新宿線(都営地下鉄)", "新宿線,都営地下鉄"],
      ["三田線(都営地下鉄)", "三田線,都営地下鉄"],
      ["池袋線(西武鉄道)", "池袋線,西武鉄道"],
      ["国分寺線(西武鉄道)", "国分寺線,西武鉄道"],
      ["新宿線(西武鉄道)", "新宿線,西武鉄道"],
      ["西武園線(西武鉄道)", "西武園線,西武鉄道"],
      ["多摩川線(西武鉄道)", "多摩川線,西武鉄道"],
      ["多摩湖線(西武鉄道)", "多摩湖線,西武鉄道"],
      ["豊島線(西武鉄道)", "豊島線,西武鉄道"],
      ["拝島線(西武鉄道)", "拝島線,西武鉄道"],
      ["有楽町線(西武鉄道)", "有楽町線,西武鉄道"],
      ["井の頭線(京王電鉄)", "井の頭線,京王電鉄"],
      ["京王線(京王電鉄)", "京王,京王電鉄"],
      ["競馬場線(京王電鉄)", "競馬場線,京王電鉄"],
      ["動物園(京王電鉄)", "動物園,京王電鉄"],
      ["池上線(東急電鉄)", "池上線,東急電鉄"],
      ["大井町線(東急電鉄)", "大井町線,東急電鉄"],
      ["世田谷線(東急電鉄)", "世田谷線,東急電鉄"],
      ["多摩川線(東急電鉄)", "多摩川線,東急電鉄"],
      ["田園都市線(東急電鉄)", "田園都市線,東急電鉄"],
      ["東横線(東急電鉄)", "東横線,東急電鉄"],
      ["みなとみらい線(東急電鉄)", "みなとみらい線,東急電鉄"],
      ["目黒線(東急電鉄)", "目黒線,東急電鉄"],
      ["伊勢崎線(東武鉄道)", "伊勢崎線,東武鉄道"],
      ["亀戸線(東武鉄道)", "亀戸線,東武鉄道"],
      ["東上線(東武鉄道)", "東上,東武鉄道"],
      ["東武スカイツリーライン(東武鉄道)", "東武スカイツリーライン,東武鉄道"],
      ["押上線(京成電鉄)", "押上線,京成電鉄"],
      ["金町線(京成電鉄)", "金町線,京成電鉄"],
      ["京成本線(京成電鉄)", "京成本線,京成電鉄"],
      ["成田スカイアクセス線(京成電鉄)", "成田スカイアクセス線,京成電鉄"],
      ["北総線(京成電鉄)", "北総線,京成電鉄"],
      ["京浜急行本線(京浜急行電鉄)", "京急,京急電鉄"],
      ["大師線(京浜急行電鉄)", "大師線,京急電鉄"],
      ["小田原線(小田急電鉄)", "小田原線,小田急電鉄"],
      ["多摩線(小田急電鉄)", "多摩線,小田急電鉄"],
      ["りんかい線(東京臨海高速鉄道)", "りんかい線,りんかい線"],
      ["グリーンライン(横浜市営地下鉄)", "グリーンライン,横浜市営地下鉄"],
      ["ブルーライン(横浜市営地下鉄)", "ブルーライン,横浜市営地下鉄"],
      ["多摩モノレール", "多摩モノレール,多摩モノレール"],
      ["つくばエクスプレス", "つくばエクスプレス,つくばエクスプレス"],
      ["東京モノレール", "東京モノレール,東京モノレール"],
      ["日暮里・舎人ライナー", "日暮里・舎人ライナー,日暮里・舎人ライナー"],
      ["ゆりかもめ", "ゆりかもめ,ゆりかもめ"]
      ]
    end

    def info_params
      params.require(:info).permit(:station1, :station2, :longitude_latitude1, :longitude_latitude2,
        :route1, :route2, :route3, :route4, :day, :push_time, :push_time2, :line_user_id)
    end

    def client
      @client ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
    end

    def template
      {
        "type": "template",
        "altText": "リンクから情報を登録してください",
        "template": {
          type: 'buttons',
          text: '下のリンクから登録してください',
            "actions": [
                {
                  "type": 'uri',
                  "label": "情報登録",
                  #commuteinfoにパラメーターを足してみる！！！！！！！！！
                  "uri": "https://commute-info.net?line_user_id=#{@line_user_id}"
                }
            ]
        }
      }
    end

    def template2
      {
        "type": "template",
        "altText": "リンクから編集や削除を行ってください",
        "template": {
          type: 'buttons',
          text: '下のリンクから「編集」or「削除」を行ってください',
            "actions": [
                {
                  "type": 'uri',
                  "label": "登録情報一覧",
                  #commuteinfoにパラメーターを足してみる！！！！！！！！！
                  "uri": "https://commute-info.net/index?line_user_id=#{@line_user_id}"
                }
            ]
        }
      }
    end

    def has_param_line_user_id_param
      @line_user_id = ""
      if params[:line_user_id]
        @line_user_id = params[:line_user_id]
      end
    end

    def access_from_index
      if !request.referer
        @access_warn = ""
      elsif request.referer && !request.referer.include?("/index?line_user_id=#{Info.find(params[:id]).line_user_id}")
        @access_warn = ""
      end
    end

    def invalid_access1
      unless request.referer && request.referer.include?("/index?line_user_id=#{Info.find(params[:id]).line_user_id}")
        redirect_to "/invalid-access"
      end
    end

    def invalid_access2
      if request.referer && request.referer.include?("commute-info.net/?line_user_id=")
      elsif request.referer && request.referer.include?("create")
      else
        redirect_to "/invalid-access"
      end
    end

    def invalid_access3
      unless request.referer && request.referer.include?("/edit")
        redirect_to "/invalid-access"
      end
    end

end
