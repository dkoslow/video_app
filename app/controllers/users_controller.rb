class UsersController < ApplicationController
  before_action :user_is_signed_in,    only: [:show, :edit, :update]
  before_action :user_is_correct_user, only: [:show, :edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :password, :password_confirmation)
    end

    def user_is_correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
