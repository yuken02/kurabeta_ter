class TabsController < ApplicationController

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
        render '/search'
      end
    else
      redirect_to "/search", notice: "これ以上タブは作れません。"
    end
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

  # def tab_params
  #   params.require(:tab).permit(:name, :user_id)
  # end
end


# <!-- タブ作成form -->
# <% if @tabs_count < 3 %>
#   <div class="col-12">
#     <%= form_with model: @tab_new, local: true, class: 'row' do |f| %>
#       <div class="form-group">
#         <%= f.text_field :name, placeholder: '新しいタブ', class: 'mr-2' %>
#       </div>
#       <div class="form-group">
#         <%= f.submit '作成', class: 'btn btn-sm btn-info' %>
#       </div>
#     <% end %>
#   </div>
# <% end %>