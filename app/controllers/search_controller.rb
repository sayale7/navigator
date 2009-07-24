class SearchController < ApplicationController
  
  def search_index
    debugger
    @pages = Page.search params[:search]
    @posts = Post.search params[:search]
  end
  
end
