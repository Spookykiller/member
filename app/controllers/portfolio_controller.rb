class PortfolioController < ApplicationController
  def show  
    @user = User.find_by(fullname: params[:fullname])
    @posts = Post.all.order(created_at: :desc)
  end 
end
