class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :index]
  before_action :find_user, only: [:show, :update]

  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  def index
    render json: User.all
  end

  def show
    render json: @user
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user.id)
      render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

  def update
  @user.update(user_params)
  if @user.save
    render json: @user, status: :accepted
  else
    render json: {errors: @user.errors.full_messages}, status: :unprocessible_entity
  end
end


  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
