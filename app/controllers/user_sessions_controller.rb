class UserSessionsController < ApplicationController
   before_action :require_login, only: [:destroy]

  def new

    @user = User.new

  end

  def create
    if @user = login(params[:email], params[:password])
      #redirect_back_or_to(:users, notice: 'Login successful')
      redirect_to(:root, notice: 'Login Successful!')
    else
      flash.now[:notice] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:login, notice: 'Logged out!')
  end
end
