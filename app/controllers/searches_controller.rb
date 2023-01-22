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
      # activerecord_relationを配列に変換
      @tabs_h = @tabs.pluck(:name, :id)

      ## 登録ワード
      @word_new = Keyword.new
      @word_count = 0
      if Keyword.exists?(tab_id: [@tabs.first])
        @word = Keyword.where(tab_id: [
          @tabs.each do |t|
            t.id
          end
        ])
        @word_count = @word.count
      end
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
      @tweet_count = @tweets['data'].length
    end
  end

end

    # orig_array = []
    # orig_hash.each_pair do |k,v|
    #   orig_array << [v, k]
    # end
    # orig_hash.to_h

# <!-- memo -->
# <%= @tweets %>

# <p></p>
# <% @tweets.each do |tweet| %>
#   <%= @tweets['data'][0] %>
# <% end %>

# <p></p>
# <p>ツイートカウント</p>
# <% @tweet_count.times do |i| %>
#   <%= @tweets['data'][i]['tweet_count'] %>,
# <% end %>
# <%= @tweet_count %>
# <%= @tweets.find_all{|y| y == ['tweet_count']} %>


### メモ ###
# byebug
# binding.pry

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

# .to_s(:delimited) 小数点

# if Tab.exists?(user_id: [current_user.id])
#   @tabs = Tab.where(user_id: current_user.id)
#   @tabs_count = @tabs.count
#   ## activerecord_relationを配列に変換
#   # @tabs_h = @tabs.pluck(:id, :name).to_h
#   # ハッシュ...{'1'=>'犬','2'=>'猫','3'=>'犬'}
#   # @tabs_h = @tabs.pluck(:id, :name)
#   # 配列...['1','犬']['2','猫']['3','犬']

#   # @tabs_h = @tabs.pluck(:id, :name).to_h.invert　=>　{'犬'=>'1,3','猫'=>'2'}
#   # @tabs_h_inv = safe_invert_hash(@tabs_h)

#   @tabs_h = @tabs.pluck(:name, :id)  <= これ
#   # 配列...['犬','1']['猫','2']['犬','1']

#   # pluck ... 指定したカラムの値を配列にできる
# end

# <%= image_tag "/assets/sign-in-with-twitter-gray.png.twimg.1920.png" %>

# @tab_all = Tab.all.to_a  #内容確認用
# @key_all = Keyword.all.to_a  #内容確認用

# <div>
#   <%= render 'chart' %>
# </div>

# <div>
#   <%= render 'charts' %>
#   <%= @comparison_ar %>
#   <%= @result_tws %>
# </div>

### charts.html.erb
# <canvas id="weekChart"></canvas>

# <script>
#   var ctx = document.getElementById("weekChart");

#   var weekChart = new Chart(ctx, {
#     type: 'line',
#     data: {
#       labels: ['7日前', '6日前', '5日前', '4日前', '3日前', '2日前', '1日前', '今日'],
#       datasets: [
#         <% @result_tws.each_with_index do |tw, twi| %>
#           {
#             label: '<%= @comparison[twi] %>',
#             data: [
#               <% @tweet_count.times do |i| %>
#                 <%= tw['data'][i]['tweet_count'] %>,
#               <% end %>
#             ],
#             borderColor: '<%= @color[twi] %>',
#             backgroundColor: 'rgba(0,0,0,0)'
#           },
#         <% end %>
#       ],
#     },
#     options: {
#       title: {
#         dispray: true,
#       },
#       scales: {
#         yAxes: [{
#           ticks: {
#             suggestedMax: 1000,
#             suggestedMin: 0,
#             stepSize: 10000,
#           }
#         }]
#       },
#     }
#   });
# </script>
