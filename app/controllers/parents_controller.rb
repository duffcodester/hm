class ParentsController < ApplicationController
  def new
    @parent = Parent.new
  end

  def show
    @parent = Parent.find(params[:id])
  end

  def edit
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
end
