module MainHelper
  def index_banner
    banner = IndexBanner.where(published: true).order(position: :asc)
  end
end
