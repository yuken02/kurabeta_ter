class SearchesController < ApplicationController

  def index
    require 'json'
    require 'uri'
    require 'net/http'

    ## 検索機能
    @keyword = params[:keyword]
    search_keyword(@keyword)

    ### ログイン時
    if user_signed_in?
      @user = current_user

      ## 比較(チェックボックス)
      @comparison = params[:keywords]
      if @comparison
        if @comparison.include?("0")
          @comparison.delete("0")
        end
        @result_tws = []
        @comparison.each_with_index do |c,i|
          search_keyword(c)
          @result_tws << @tweets
        end
        @color = ['royalblue', 'red', 'mediumseagreen', 'orange', 'indigo', 'gold', 'lightsteelblue', 'lawngreen', 'violet', 'maroon']
      end

      ## タブ
      @tab_new = Tab.new
      @tabs = Tab.where(user_id: current_user.id)
      @tabs_count = @tabs.count

      ## 登録ワード
      @word_new = Keyword.new
      @word = Keyword.where(tab_id: @tabs.ids)
    end
  end


  private

  def search_keyword(key)
    ## HTTPリクエスト
    enc_keyword = URI.encode_www_form_component(key)
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

    ## チャートdataのtimes用
    if @tweets.include?('data')
      @tweet_count_times = @tweets['data'].length
    end
  end

end