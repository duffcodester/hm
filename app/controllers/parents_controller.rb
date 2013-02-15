class ParentsController < ApplicationController
  before_filter :signed_in_parent, only: [:index, :edit, :update, :destroy]
  before_filter :correct_parent, only: [:edit, :update]
  before_filter :admin_parent, only: :destroy

  def new
    @parent = Parent.new
  end

  def show
    @parent = Parent.find(params[:id])
    @assigned_challenges = @parent.assigned_challenges.where("parent_id =?", @parent.id).where("accepted =?", false).where("rejected =?", false).where("completed =?", false).where("validated =?", false)
    @accepted_challenges = @parent.assigned_challenges.where("parent_id =?", @parent.id).where("accepted =?", true)
    @rejected_challenges = @parent.assigned_challenges.where("parent_id =?", @parent.id).where("rejected =?", true)
    @completed_challenges = @parent.assigned_challenges.where("parent_id =?", @parent.id).where("completed =?", true)
    @validated_challenges = @parent.assigned_challenges.where("parent_id =?", @parent.id).where("validated =?", true)
    @enabled_rewards = @parent.enabled_rewards.where("parent_id =?", @parent.id)
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

  def destroy
    Parent.find(params[:id]).destroy
    flash[:success] = "Parent destroyed"
    redirect_to parents_url
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

    def admin_parent
      redirect_to(root_path) unless current_user.admin?
    end
end
