class TabsController < ApplicationController

  def create
    @tab_new = Tab.new(tab_params)
    @tab_new.user_id = current_user.id
    if @tab_new.save
      redirect_to search_path, notice: "タブを作成しました"
    else
      @keyword = params[:keyword]
      render '/search'
    end
  end

  def edit
    @tab = Tab.find(params[:id])
  end

  def update
    @tab = Tab.find(params[:id])
    @tab.user_id = current_user.id
    if @tab.update(tab_params)
      redirect_to "/search", notice: "タブの名前を変更しました。"
    else
      render "/search"
    end
  end


  private

  def tab_params
    params.require(:tab).permit(:name, :user_id)
  end
end