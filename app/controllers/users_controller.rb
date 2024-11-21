class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[index]

  def index
    @users = User.order(:id)
  end
end
