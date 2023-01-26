class TabsController < ApplicationController
  before_action :authenticate_user!, only: [:create,:update]

  def create
    @tab_new = Tab.new
    @tabs = Tab.where(user_id: current_user.id)
    if @tabs.count <= 2
      @tab_new.name = 'タブ'
      @tab_new.user_id = current_user.id
      if @tab_new.save
        redirect_to search_path, notice: "タブを作成しました"
      else
        @keyword = params[:keyword]
        redirect_to request.referer
      end
    else
      redirect_to "/search", alert: "これ以上タブは作れません"
    end
  end

  def update
    @tab = Tab.find(params[:id])
    @tab.user_id = current_user.id
    if @tab.update(tab_params)
      redirect_to "/search", notice: "タブの名前を変更しました。"
    else
      redirect_to request.referer, alert: "変更に失敗しました"
      # @tab_new = Tab.new
      # @tabs = Tab.where(user_id: current_user.id)
      # @tabs_count = @tabs.count
      # # activerecord_relationを配列に変換
      # @tabs_h = @tabs.pluck(:name, :id)
      # @word_new = Keyword.new
      # @word_count = 0
      # if Keyword.exists?(tab_id: [@tabs.first])
      #   @word = Keyword.where(tab_id: [
      #     @tabs.each do |t|
      #       t.id
      #     end
      #   ])
      #   @word_count = @word.count
      # end
      # render 'searches/index'
    end
  end


  private

  def tab_params
    params.require(:tab).permit(:name, :user_id)
  end
end