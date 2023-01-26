class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
  end

  def update

  end
end