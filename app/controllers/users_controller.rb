class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy follow unfollow ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /users/1/follow
  def follow
    follower = User.find(params.require(:follower_id))
    relationship = follower.follow(@user)

    respond_to do |format|
      if relationship.persisted?
        format.html { redirect_to @user, notice: "#{follower.name} is now following #{@user.name}." }
        format.json { render json: relationship, status: :created }
      else
        format.html { redirect_to @user, alert: relationship.errors.full_messages.to_sentence }
        format.json { render json: relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1/unfollow
  def unfollow
    follower = User.find(params.require(:follower_id))
    follower.unfollow(@user)

    respond_to do |format|
      format.html { redirect_to @user, notice: "#{follower.name} is no longer following #{@user.name}." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
