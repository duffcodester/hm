class ParentsController < ApplicationController
  before_filter :signed_in_parent, only: [:index, :edit, :update]
  before_filter :correct_parent, only: [:edit, :update]

  def new
    @parent = Parent.new
  end

  def show
    @parent = Parent.find(params[:id])
  end

  def edit
  end

  def index
    @parents = Parent.paginate(page: params[:page])
  end

  def update
    if @parent.update_attributes(params[:parent])
      flash[:success] = "Profile updated!"
      sign_in @parent
      redirect_to @parent
    else
      render 'edit'
    end
  end

  def create
    @parent = Parent.new(params[:parent])
    if @parent.save
      sign_in @parent
      flash[:success] = "Welcome to HealthMonster! You have successfully created your account"
      redirect_to @parent
    else
      render 'new'
    end
  end

  private

    def signed_in_parent
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_parent
      @parent = Parent.find(params[:id])
      redirect_to(root_path) unless current_user?(@parent)
    end
end
