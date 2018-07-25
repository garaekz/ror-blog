class PagesController < ApplicationController
  def home
    @articles = Article.paginate(page: params[:page], per_page: 5).order('id DESC')
  end
  def about
    
  end
  def login
    
  end
end