class UsersController < ApplicationController
  
  access_control do   
    allow :admin
    allow logged_in, :to => [:show, :edit, :update]
  end
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Benutzer erflogreich angelegt."
      redirect_to @user
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Benutzer erfolgreich geändert."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end
  
  def destroy_user
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully destroyed user."
    redirect_to root_url
  end
  
end
