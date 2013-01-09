class ChildrenController < ApplicationController
  def new
    @child = Child.new
  end

  def your
    @your_children = current_user.children
  end

  def show
    @child = Child.find(params[:id])
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
end
