include ConstDefinition

class UsersController < ApplicationController
  before_filter :require_login, :only => [:show, :edit, :update]
  before_filter :only_admin,    :only => [:index]
  before_action :set_user, only: [:show, :edit, :update, :edit_password, :update_password]
  before_filter :ope_user_filter, only: [:show, :edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @reports = current_user.reports
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @city = current_user.city
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    city = City.where(id: params[:user][:city_id]).first
    @user.city = city

    @user.right = USER_RIGHT

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if params[:user][:icon_image]
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if User.update_except_for_image_path(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # TODO update_password

  def edit_password
  end

  def update_password
    if @user.valid_password?(params[:user][:current_password])
      @user.password = params[:user][:new_password]
      @user.password_confirmation = params[:user][:new_password_confirmation]
      respond_to do |format|
        if @user.save
        format.html { redirect_to user_path(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :created, location: @user }
        else
        format.html { render :edit_password }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      @user.errors.add(:base, "current password invalid!")

      respond_to do |format|
        format.html { render :edit_password }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def ope_user_filter
    redirect_to :root if @user != current_user and current_user.right != ADMIN_RIGHT
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :icon_image, :icon_image_cache, :title, :description)
  end

end
