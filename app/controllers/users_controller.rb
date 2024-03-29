class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit destroy]

  def show; end

  def edit; end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user), notice: 'Your bio was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :full_name, :photo)
  end
end
