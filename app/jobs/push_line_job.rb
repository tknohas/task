class PushLineJob < ApplicationJob
  queue_as :default

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_id = Rails.application.credentials.LINE_CHANNEL_ID
      config.channel_secret = Rails.application.credentials.LINE_CHANNEL_SECRET
      config.channel_token =  Rails.application.credentials.LINE_CHANNEL_TOKEN
    }
  end

  def perform(*args)
    Task.incomplete.assigned_user.order(:id).each do |task|
      user = User.find(task.executor_id)
      key = user.line_user_key
      message={
        type: 'text',
        text: "#{task.title}を完了してください"
      }
      client.push_message(key, message, headers: {}, payload: {})
    end
  end
end
