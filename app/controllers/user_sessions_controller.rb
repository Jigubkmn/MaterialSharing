class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new ;end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to root_path, success: t('user_sessions.create.success')
    else
      @user = User.new(email: params[:email])
      flash.now[:danger] = t('user_sessions.create.danger')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, success: t('user_sessions.destroy.success')
  end
end