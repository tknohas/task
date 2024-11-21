class Users::SignInsController < ApplicationController
  allow_unauthenticated_access only: %i[create]
  
  def create
    @user = User.find(params[:user_id])
    start_new_session_for @user
    redirect_to tasks_path
  end
end
