class ServiceController < ApplicationController
  def show
    @page = Service.find_by_slug(params[:name])
    @other = Service.order(created_at: :asc).where.not(id: @page.id).limit(3)
  end
  def all
    @services = Service.order(position: :asc).where(published: true)
  end
end
