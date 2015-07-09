class UsersController < ApplicationController
  def new
    if params[:forward_to]
      session[:forward_to] = params[:forward_to]
    else
      session[:return_to] ||= request.referer
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to seller_dashboard_path(@user.slug)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :display_name, :email, :street_1,
                                 :street_2, :city, :state, :zipcode, :password,
                                 :password_confirmation)
  end
end
