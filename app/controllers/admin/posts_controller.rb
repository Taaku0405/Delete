class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @posts = Post.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
