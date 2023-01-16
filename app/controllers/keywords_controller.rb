class KeywordsController < ApplicationController

  def create
    # Tab.tab_check
    @word_new = Keyword.new(word_params)
    if @word_new.save
      redirect_to search_path, notice: "キーワードを登録しました"
    else
      @keyword = params[:keyword]
      render '/search'
    end
  end

  def update
  end

  def destroy
    @word = Keyword.find(params[:id])
    @word.destroy
    redirect_to "/search"
  end


  private
  # model
  # def self.tab_check
  #   find_or_create_by!(user_id: current_user.id) do |tab|
  #     tab.name = 'タブ1'
  #     tab.user_id = current_user.id
  #   end
  # end

  def word_params
    params.require(:keyword).permit(:word, :tab_id)
  end
end
