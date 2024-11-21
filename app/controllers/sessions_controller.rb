class SessionsController < ApplicationController
  def destroy
    terminate_session
    redirect_to users_path
  end
end
