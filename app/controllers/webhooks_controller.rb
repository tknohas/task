class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  allow_unauthenticated_access only: [:create]

  def create
    body = request.body.read
    events = client.parse_events_from(body)
    
    events.each do |event|
      case event
      when Line::Bot::Event::Follow
        line_user_key = event['source']['userId']
        User.find_or_create_by!(line_user_key:)
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          line_user_key = event['source']['userId']
          user = User.find_by!(line_user_key:)
          Task.create!(user:, title: event.message['text'], description: '')
          task = Task.last
          message = [
            {
              type: 'text',
              text: '登録しました。'
            },
            {
              type: 'text',
              text: task_url(task)
            },
          ]
          client.reply_message(event['replyToken'], message)
        end
      end
    end
    "OK"
  end

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_id = Rails.application.credentials.LINE_CHANNEL_ID
      config.channel_secret = Rails.application.credentials.LINE_CHANNEL_SECRET
      config.channel_token =  Rails.application.credentials.LINE_CHANNEL_TOKEN
    }
  end
end
