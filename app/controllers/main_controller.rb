class MainController < ApplicationController

  before_filter :filters, only: :index
  caches_page :index

  def index
    @categories = Category.where(published: true).order(index_sort: :asc).limit(4)
    @regions = WorkRegion.where(published: true).order(created_at: :asc )
    @publication = Publication.where(published: true).order(created_at: :desc).limit(4)

  end
  def error_404
    
  end
  def saitmap

  end
  def privacy
    @page = Regulations.where(published: true).first
  end
end
