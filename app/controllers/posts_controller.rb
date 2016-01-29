class PostsController < ApplicationController
    before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
    before_action :authenticate_user!
    before_action :owned_post, only: [:edit, :update, :destroy]
    
    def index
        @posts = Post.all.order(created_at: :desc)
        @comments = Comment.where(post_id: @post)
    end
    
    def show
        @comments = Comment.where(post_id: @post)
    end
    
    def new
        @post = current_user.posts.build
    end
    
    def create
        @post = current_user.posts.build(post_params)
        
        if @post.save
            redirect_to @post, notice: "Aangemaakt"
        else
            render 'new'
        end
    end
    
    def edit
    end
    
    def update
        if @post.update(post_params)
            redirect_to @post, notice: "Geupdate"
        else
            render 'edit'
        end
    end
    
    def destroy
        @post.destroy
        redirect_to root_path, alert: "Verwijderd"
    end
    
    def upvote
        @post.upvote_by current_user
        redirect_to :back
    end
    
    def downvote
        @post.downvote_by current_user
        redirect_to :back
    end
    
    private
        def find_post
            @post = Post.find(params[:id])
        end
        
        def post_params
            params.require(:post).permit(:title, :description, :image, :portfolio_condition)
        end
        
        def owned_post
            unless @post.user.id == current_user.id
              redirect_to root_path, alert: "Hier heeft u geen rechten voor!"
            end
        end
end
