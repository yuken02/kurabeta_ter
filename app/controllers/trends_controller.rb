class TrendsController < ApplicationController
  def index
    client = Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット
      config.consumer_key = ENV['API_KEY']
      config.consumer_secret = ENV['API_KEY_SECRET']
      config.access_token = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end

    # @rank = for i in 1..30 do
    #   i += 1
    # end

    # @rank = (1..30).each{|i|
    #   puts i.to_s
    # }

    @rank = 1..30
    # @rank.each do |i|
    #   i
    # end

    @trends = client.trends(id = 23424856).attrs[:trends].first(30)
    # @trends = get_trends.each do |trend|
    #     name = trend[:name]
    #     url = trend[:url]
    #     promoted_content = trend[:promoted_content]
    #     query = trend[:query]
    #     tweet_volume = trend[:tweet_volume]
    #     # puts "#{name}, #{url}, #{promoted_content}, #{query}, #{tweet_volume}"
    #   end

    # @trends = JSON.parse(get_trends)
  end
end