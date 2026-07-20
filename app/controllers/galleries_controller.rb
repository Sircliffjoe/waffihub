class GalleriesController < ApplicationController
  def index
    @page_title = "Gallery"
    @gallery_images = GalleryImage.all.order(event_date: :desc, created_at: :desc)
    
    # We can group them by category if needed, or just display them in a masonry grid.
  end
end
