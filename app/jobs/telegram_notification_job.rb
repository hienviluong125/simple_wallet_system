class TelegramNotificationJob < ApplicationJob
  queue_as :default

  def perform(text)
    token = ENV['BOT_TOKEN']

    return if token.blank?

    chat_ids = get_chat_ids

    return if chat_ids.blank?

    chat_ids.each do |chat_id|
      HTTParty.post(
        "https://api.telegram.org/bot#{token}/sendMessage",
        body: {
          chat_id: chat_id,
          text: text
        }
      )
    end
  end

  private

  def get_chat_ids
    token = ENV['BOT_TOKEN']
    get_updates_response = HTTParty.get("https://api.telegram.org/bot#{token}/getUpdates")
    chat_ids = []

    if get_updates_response['ok']
      chat_res = get_updates_response['result']

      chat_res.each do |res|
        if res['message'].present?
          if left_chat_member_message = res['message']['left_chat_member']
            if (
              left_chat_member_message['is_bot'] &&
              left_chat_member_message['first_name'] == ENV['BOT_NAME'] &&
              left_chat_member_message['username'] == ENV['BOT_USERNAME']
            )
              chat_ids.delete(res['message']['chat']['id'])
              next
            end
          end

          chat_ids << res['message']['chat']['id']
        end
      end
    end

    chat_ids.uniq
  end
end