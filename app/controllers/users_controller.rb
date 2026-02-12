class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: [ :show, :update, :destroy ]

  def index
    @users = User.all
    render json: @users
  end


  def show
    render json: @user
  end

  def create
  @user = User.new(user_params)

  if @user.save
    render json: { message: "user created successfully", data: @user }, status: :created
  else
    render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
  end

rescue ActiveRecord::RecordNotUnique
  render json: { error: "Email already exists" }, status: :unprocessable_entity
end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    render json: { message: "User deleted" }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :age)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
