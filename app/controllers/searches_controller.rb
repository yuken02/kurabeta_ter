class SearchesController < ApplicationController

  def index
    ### 検索機能
    require 'json'
    require 'uri'
    require 'net/http'

    ## HTTPリクエスト
    @keyword = params[:keyword]
    enc_keyword = URI.encode_www_form_component(@keyword)
    bearer_token = ENV['BEARER_TOKEN']
    uri = URI.parse("https://api.twitter.com/2/tweets/counts/recent?query=#{enc_keyword}&granularity=day")
    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req = Net::HTTP::Get.new(uri.request_uri)
    req["Authorization"] = "bearer #{bearer_token}"

    ## JSON => ハッシュ
    res = http.request(req)
    @tweets = JSON.parse(res.body)
    if @tweets.include?('data')
      @tweet_count = @tweets['data'].length
    end
    @tab_all = Tab.all.to_a  #チェック用
    @key_all = Keyword.all.to_a

    ### ログイン時
    if user_signed_in?
      ## タブ
      @tab_new = Tab.new
      if Tab.exists?(user_id: [current_user.id])
        @tabs = Tab.where(user_id: current_user.id)
        @tabs_count = @tabs.count
        ## activerecord_relationを配列に変換
        @tabs_h = @tabs.pluck(:name, :id)
        # @tabs_h = @tabs.pluck(:id, :name).to_h
        # @tabs_h = @tabs.pluck(:id, :name).to_h.invert
        # @tabs_h_inv = safe_invert_hash(@tabs_h)
      end

      ## 登録ワード
      @word_new = Keyword.new
      if Keyword.exists?(tab_id: [@tabs.first])
        @word = Keyword.where(tab_id: [
          @tabs.each do |t|
            t.id
          end
        ])
      end

      ## 比較
      @comparison = params[:keywords]
      if @comparison
        # @com_l = @comparison.length
        if @comparison.include?("0")
          @comparison.delete("0")
        end
        @comp_tws = []
        # @com_h = @comparison_ar.to_h
        @comparison.each_with_index do |c,i|
          # byebug
          enc_keywords = URI.encode_www_form_component(c)
          # binding.pry
          uri_s = URI.parse("https://api.twitter.com/2/tweets/counts/recent?query=#{enc_keywords}&granularity=day")
          http_s = Net::HTTP.new(uri_s.host, uri_s.port)

          http_s.use_ssl = true
          http_s.verify_mode = OpenSSL::SSL::VERIFY_NONE

          req_s = Net::HTTP::Get.new(uri_s.request_uri)
          req_s["Authorization"] = "bearer #{bearer_token}"

          res_s = http_s.request(req_s)
          @tweets = JSON.parse(res_s.body)
          @comp_tws << @tweets
        end
          if @tweets.include?('data')
            @tweet_count = @tweets['data'].length
          end
          @color = ['blue', 'red', 'orange', 'green', 'indigo', 'maroon']
      end

    end
  end


  private

  # def safe_invert(orig_hash)
  #   orig_hash.each_key.group_by do |key|
  #   orig_hash[key]
  #   end
  # end

  # def safe_invert_hash(orig_hash)
  #   orig_array = []
  #   orig_hash.each_pair do |k, item|
  #     if item.count > 1
  #       item.each do |itm|
  #         orig_array << [itm, k]
  #       end
  #     else
  #       orig_array << [item.first, k]
  #     end
  #   end
  #   result = Hash.new do |h, key| h[key] = [] end
  #   orig_array.each do |key, value|
  #     result[key] << value
  #   end
  #   result
  # end

  # def safe_invert
  #   inject(Hash.new{ |h,k| h[k] = [] }) do |hash, (val, keys)|
  #     [*keys].each{ |key| hash[key] << val }
  #     hash
  #   end
  # end

  # def safe_invert_hash(orig_hash)
  #   hash = Hash.new do|h,k| h[k] = [] end
  #   orig_hash.each do |key, val|
  #     hash[key] << val
  #     # keys = key
  #     hash[val] = key
  #   end
  #   hash
  # end

    # hash = Hash.new{|hash, key| hash[key] = []} do |h, (val, k)|
    #   orig_hash.each do |k,v| h[k] << val
    #   end
    # end
# h = Hash.new{|h, key| h[key] = []}
end

    # orig_array = []
    # orig_hash.each_pair do |k,v|
    #   orig_array << [v, k]
    # end
    # orig_hash.to_h

### メモ ###

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

# each_with_index の値は0から