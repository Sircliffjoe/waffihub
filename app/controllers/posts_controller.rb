class PostsController < ApplicationController
  def index
    @page_title = "Hub News"
    @posts = Post.all.order(published_at: :desc)
  end

  def show
    @post = Post.find_by!(slug: params[:id])
    @page_title = @post.title
  end
end
