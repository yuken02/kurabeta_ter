class KeywordsController < ApplicationController
  before_action :authenticate_user!, only: [:create,:destroy]

  def create
    tabs = Tab.where(user_id: current_user.id)
    word = Keyword.where(tab_id: tabs.ids)
    @word_new = Keyword.new(word_params)
    if word.count < 30
      if @word_new.save
        # redirect_to search_path, notice: "キーワードを登録しました"
      else
        @keyword = params[:keyword]
        redirect_to request.referer, alert: "キーワードの登録に失敗しました"
      end
    end
    @tab = @word_new.tab

    @tabs = Tab.where(user_id: current_user.id)
    @tabs_count = @tabs.count
    @tab_new = Tab.new
    @words = Keyword.where(tab_id: @word_new.tab_id)
  end

  def destroy
    word = Keyword.find(params[:id])
    @tab = word.tab
    word.destroy
    @tabs = Tab.where(user_id: current_user.id)
    @tabs_count = @tabs.count
    @tab_new = Tab.new
    @words = Keyword.where(tab_id: @tab.id)
    # redirect_to request.referer, notice: "キーワードを削除しました"
  end


  private

  def word_params
    params.require(:keyword).permit(:word, :tab_id)
  end
end
