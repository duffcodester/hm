class ChildrenController < ApplicationController
before_filter :signed_in_child, only: [:index, :edit, :update, :destroy]
before_filter :correct_child, only: [:edit, :update]
before_filter :admin_parent, only: :destroy
#before_filter :admin, [:index]

  def new
    @child = Child.new
  end

  def your
    @your_children = current_user.children
  end

  def show
    @child = Child.find(params[:id])
    @assigned_challenges = @child.assigned_challenges.where("child_id =?", @child.id).where("accepted =?", false).where("rejected =?", false).where("completed =?", false).where("validated =?", false)
    @accepted_challenges = @child.assigned_challenges.where("child_id =?", @child.id).where("accepted =?", true)
    @enabled_rewards = @child.enabled_rewards.where("child_id =?", @child.id).where("redeemed =?", false)
  end

  def show_old # no longer used
    @child = Child.find(params[:id])
    @assigned_challenges = @child.assigned_challenges.where("child_id =?", @child.id).where("accepted =?", false).where("rejected =?", false).where("completed =?", false).where("validated =?", false)
    @accepted_challenges = @child.assigned_challenges.where("child_id =?", @child.id).where("accepted =?", true)
    @rejected_challenges = @child.assigned_challenges.where("child_id =?", @child.id).where("rejected =?", true)
    @completed_challenges = @child.assigned_challenges.where("child_id =?", @child.id).where("completed =?", true)
    @enabled_rewards = @child.enabled_rewards.where("child_id =?", @child.id).where("redeemed =?", false)
    @validated_challenges = @child.assigned_challenges.where("validated =?", true)
  end

  def dash
  end

  def edit
  end

  def index
    @children = Child.paginate(page: params[:page])
  end

  def update
    if @child.update_attributes(params[:child])
      flash[:success] = "Profile updated"
      sign_in @child
      redirect_to @child
    else
      render 'edit'
    end
  end

  def create
    @child = current_user.children.build(params[:child])
    if @child.save
      flash[:success] = "You have successfully created your child's account!"
      redirect_to @child
    else
      render 'new'
    end
  end

  def destroy
    Child.find(params[:id]).destroy
    flash[:success] = "Child destroyed"
    redirect_to children_url
  end

  private

    def signed_in_child
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_child
      @child = Child.find(params[:id])
      redirect_to(root_path) unless current_user?(@child)
    end

    def admin_parent
      redirect_to(root_path) unless current_user.admin?
    end
end
