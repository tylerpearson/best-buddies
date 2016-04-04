class UsersController < ApplicationController

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Thanks!"
      redirect_to results_path(@user.username)
    else
      flash[:error] = "Something went wrong!"
      redirect_to results_path(@user.username)
    end
  end

  def results_check
    @user = User.find(params[:id])
    return render json: {hasResults: false} if @user.nil?

    if @user.has_results?
      render json: {hasResults: true, username: @user.username}
    else
      render json: {hasResults: false}
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :shared)
    end

end
