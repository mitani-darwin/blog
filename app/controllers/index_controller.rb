class IndexController < ApplicationController
  def index
    @posts =  Post.published
  end
end
