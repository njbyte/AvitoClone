class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]
  def new
    if authenticated?
      redirect_to root_path
    else
    @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path, notice: "Compte créé avec succès. Connectez-vous."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:nom, :prenom, :email_address, :password)
  end
end
