class ParentsController < ApplicationController
  def new
    @parent = Parent.new
  end

  def show
    @parent = Parent.find(params[:id])
  end

  def create
    @parent = Parent.new(params[:parent])
    if @parent.save
      flash[:success] = "Welcome to HealthMonster! You have successfully created your account"
      redirect_to @parent
    else
      render 'new'
    end
  end
end
