class WordsController < ApplicationController

  def create
    @word_new = Keyword.new(word_params)
  end

  def update
  end


  private

  def word_params
    params.require(:keyword).permit(:word, :tag_id)
  end
end
