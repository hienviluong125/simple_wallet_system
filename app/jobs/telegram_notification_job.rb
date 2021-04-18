require 'telegram/bot'

class TelegramNotificationJob < ApplicationJob
  queue_as :default

  def perform(text)
    token = ENV['BOT_TOKEN']
    chat_ids = ENV['CHAT_IDS']

    return if token.blank? || chat_ids.blank?

    Telegram::Bot::Client.run(token) do |bot|
      chat_ids = chat_ids.split(',')
      chat_ids.each { |chat_id| bot.api.send_message(chat_id: chat_id, text: text) }
    end
  end
end