class SearchsController < ApplicationController

  def index
    require 'json'
    require 'uri'
    require 'net/http'

    keyword = URI.encode_www_form_component(params[:keyword])
    bearer_token = ENV['BEARER_TOKEN']
    uri = URI.parse("https://api.twitter.com/2/tweets/counts/recent?query=#{keyword}&granularity=hour")
    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req = Net::HTTP::Get.new(uri.request_uri)
    req["Authorization"] = "bearer #{bearer_token}"

    res = http.request(req)
    @tweets = res.body
  end
end
