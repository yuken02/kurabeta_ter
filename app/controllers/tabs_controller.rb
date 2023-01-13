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

  def update

  end


  private

  def tab_params
    params.require(:tab).permit(:name, :user_id)
  end
end