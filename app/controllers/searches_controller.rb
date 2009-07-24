class SearchesController < ApplicationController
  # GET /searches
  # GET /searches.xml
  def index
    @searches = Search.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @searches }
    end
  end
  
  def search
    @results = Page.all(:conditions => ("name like '%#{params[:search][:query]}%' or content like '%#{params[:search][:query]}%'"))
  end
  
end
