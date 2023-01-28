class TrendsController < ApplicationController
  def index
    client = Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット
      config.consumer_key = ENV['API_KEY']
      config.consumer_secret = ENV['API_KEY_SECRET']
      config.access_token = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end

    @trends = client.trends(id = 23424856).attrs[:trends].first(30)
  end
end