class SearchsController < ApplicationController

  def index
    require 'json'
    require 'uri'
    require 'net/http'

    @keyword = params[:keyword]
    enc_keyword = URI.encode_www_form_component(@keyword)
    bearer_token = ENV['BEARER_TOKEN']
    uri = URI.parse("https://api.twitter.com/2/tweets/counts/recent?query=#{enc_keyword}&granularity=day")
    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req = Net::HTTP::Get.new(uri.request_uri)
    req["Authorization"] = "bearer #{bearer_token}"

    res = http.request(req)
    @tweets = JSON.parse(res.body)
    if @tweets.include?('data')
      @tweet_count = @tweets['data'].length
    end
  end
end

# Object.keys([要素数を知りたいJSON]).length

# 36463,
#                       61044,
#                       57685,
#                       64084,
#                       61180,
#                       37406,
#                       117744,
#                       118856

# var json_count = <%= @tweets.['data'].length %>;

# <% @tweets.each_with_index do |tweet, i| %>
#   <%= @tweets['data'][i-1]['tweet_count'] %>
#   <%= @tweets['data'] %>
# <% end %>

# var json_count = Object.keys(<%= @tweets.['data']).length);