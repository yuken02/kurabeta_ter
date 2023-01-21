class KeywordsController < ApplicationController

  def create
    # Tab.tab_check
    @word_new = Keyword.new(word_params)
    if @word_new.save
      redirect_to search_path, notice: "キーワードを登録しました"
    else
      @keyword = params[:keyword]
      redirect_to request.referer
    end
  end

  def destroy
    @word = Keyword.find(params[:id])
    @word.destroy
    redirect_to request.referer
  end


  private

  def word_params
    params.require(:keyword).permit(:word, :tab_id)
  end
end
