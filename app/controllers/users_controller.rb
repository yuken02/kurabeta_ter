class UsersController < ApplicationController
  def show
  end
end

# <%= link_to user_path(current_user),class: 'nav-link text-dark' do %>
#   <% if current_user.uid.brank? %>
#     <i class="fas fa-user"></i>
#   <% else %>
#     <% if @user.image %>
#       <%= @user.iamge %>
#     <% else %>
#       <i class="fas fa-user"></i>
#     <% end %>
#   <% end %>
# <% end %>