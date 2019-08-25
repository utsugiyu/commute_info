class InfosController < ApplicationController
  require 'line/bot'

  def new
    @info = Info.new
  end

  def create
  end

  def index
  end

  def destroy
  end

  def callback
  body = request.body.read

  signature = request.env['HTTP_X_LINE_SIGNATURE']
  unless client.validate_signature(body, signature)
    error 400 do 'Bad Request' end
  end

  events = client.parse_events_from(body)

  events.each { |event|
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        if event.message['text'].include?('登録')
          client.reply_message(event['replyToken'], template)
        #elsif event.message['text'].include?('削除')
        end
      end
    end
  }

  head :ok
  end

  private

    def client
      @client ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
    end

    def template
      {
        "type": "template",
        "altText": "this is a link template",
        "template": {
            "type": "confirm",
            "text": "下のリンクを開いてください",
            "actions": [
                {
                  "type": 'uri',
                  # Botから送られてきたメッセージに表示される文字列です。
                  "label": "情報登録",
                  # ボタンを押した時にBotに送られる文字列です。
                  "uri": "line://app/1601926924-LdBre46Z"
                }
            ]
        }
      }
    end

end
