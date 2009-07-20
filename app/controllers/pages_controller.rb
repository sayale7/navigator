class PagesController < ApplicationController
  
  access_control do   
    allow :admin
    allow logged_in, :to => [:index, :show]
  end
  
  def index
    @sub_pages = Array.new
    @pages = Page.find_all_by_parent_id(nil)
  end
  
  def show
    @page = Page.find(params[:id])
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    i = 0
    temp_elem = @page
    while temp_elem.parent_id != nil
      temp_elem = Page.find(temp_elem.parent_id)
      i += 1
    end
    if(i>2)
      flash[:notice] = "Sie haben die maximale Verschachtelungstiefe erreicht."
      render :action => 'new'
    else
      @page.content = @page.content.to_s.gsub("\r", "")
      @page.content = @page.content.to_s.gsub("\n", "")
      if @page.save
        flash[:notice] = "Seite erfolgreich erstellt."
        redirect_to @page
      else
        render :action => 'new'
      end
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
  
  def set_inactive
    @page = Page.find(params[:id])
    @page.update_attribute("inactive", true)
    @page.save
    render :action => "show"
  end
  
  def set_active
    @page = Page.find(params[:id])
    @page.update_attribute("inactive", false)
    @page.save
    render :action => "show"
  end
  
  def change_page_order
    drag_elem = Page.find(params[:id])
    drop_elem = Page.find(params[:parent_id])
    
    
    i = 0
    
    temp_elem = drop_elem
    
    while temp_elem.parent_id != nil
      temp_elem = Page.find(temp_elem.parent_id)
      i += 1
    end
    
    if(i>2)
      render :update do |page|
        page.replace_html 'change',  :partial => 'layouts/change'
          page.replace_html 'nav',  :partial => "layouts/nav"
      end
    else
      if(drag_elem.id == drop_elem.id)
        render :update do |page|
          page.replace_html 'change',  :partial => 'layouts/change'
          page.replace_html 'nav',  :partial => "layouts/nav"
        end
      else
        if(drop_elem.parent_id == drag_elem.id)
          drop_elem.update_attribute("parent_id", drag_elem.parent_id)
          children = drag_elem.children
          children.each do |child|
            if(child.id == drop_elem.id)
            else
              child.update_attribute("parent_id", drop_elem.id)
            end
          end
          drag_elem.update_attribute("parent_id", drop_elem.id)
        else
          children = drag_elem.children
          children.each do |child|
            if(child.id == drop_elem.id)
            else
              child.update_attribute("parent_id", drag_elem.parent_id)
            end
          end
          drag_elem.update_attribute("parent_id", drop_elem.id)
        end
        
        render :update do |page|
          page.replace_html 'change',  :partial => 'layouts/change' 
          page.replace_html 'nav',  :partial => "layouts/nav"
        end
      end
    end
  end
  
  def set_root
    @page_to_root = Page.find(params[:id])
    children = @page_to_root.children
    children.each do |child|
      child.update_attribute("parent_id", @page_to_root.parent_id)
    end
    @page_to_root.update_attribute("parent_id", nil)
    if @page_to_root.save
      render :action => "index"
    end
  end
  
  
end
