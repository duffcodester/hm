class ChildrenController < ApplicationController
before_filter :signed_in_child, only: [:index, :edit, :update]
before_filter :correct_child, only: [:edit, :update]
#before_filter :admin, [:index]

  def new
    @child = Child.new
  end

  def your
    @your_children = current_user.children
  end

  def show
    @child = Child.find(params[:id])
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
end
