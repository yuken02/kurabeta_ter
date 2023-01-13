class KeywordsController < ApplicationController

  def create
    @word_new = Keyword.new(word_params)
    @word_new.tab_id = 1
    if @word_new.save
      redirect_to search_path, notice: "キーワードを登録しました"
    else
      @keyword = params[:keyword]
      render '/search'
    end
  end

  def update
  end


  private

  def word_params
    params.require(:keyword).permit(:word, :tab_id)
  end
end
