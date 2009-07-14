class PagesController < ApplicationController
  
  access_control do   
    allow :admin
    allow logged_in, :to => [:index, :show]
  end
  
  def index
    @pages = Page.all
  end
  
  def show
    @page = Page.find(params[:id])
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    @page.content = @page.content.to_s.gsub("\r", "")
    @page.content = @page.content.to_s.gsub("\n", "")
    if @page.save
      flash[:notice] = "Seite erfolgreich erstellt."
      redirect_to @page
    else
      render :action => 'new'
    end
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    @page.update_attributes(params[:page])
    @page.content = @page.content.to_s.gsub("\r", "")
    @page.content = @page.content.to_s.gsub("\n", "")
    if @page.save
      flash[:notice] = "Seite erfolgreich geändert."
      redirect_to @page
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @page = Page.find(params[:id])
    @pages = Page.all(:conditions => ["parent_id = #{@page.id}"])
    if(@pages.length > 0)
      flash[:notice] = "Löschen Sie bitte zuerst alle Unterseiten dieser Seite."
      redirect_to root_url
    else
      @page.destroy
      flash[:notice] = "Seite erfolgreich gelöscht."
      redirect_to root_url
    end
  end
  
end
