class WikisController < ApplicationController
  respond_to :html, :js

  def index
    @wikis = Wiki.where(public: true)
  end

  def show
    @wiki = Wiki.find(params[:id])
    if @wiki.accessible_by_current_user(current_user)
      @wiki
    else
      redirect_to "/"
    end
  end

  def new
  end

  def create
    @wiki = Wiki.new(post_params)
    @wiki.user_id = current_user.id
    @user = User.find(@wiki.user_id)
    if @wiki.save
      flash[:notice] = "Your new Wiki has been created."
      redirect_to @user
    else
      flash[:error] = "There was an error in creating your Wiki. Please start over."
      redirect_to @user
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    if @wiki.accessible_by_current_user(current_user)
      @collaborator = Collaborator.new(:wiki_id => @wiki.id)
    else
      redirect_to '/'
    end
  end

  def update
    @wiki = current_user.wikis.find(params[:id])
    @user = User.find(@wiki.user_id)
    if @wiki.update_attributes(post_params)
      flash[:notice] = "You have updated a Wiki"
      redirect_to @user
    else
      flash[:error] = "There was an error encountered. Please try again."
      redirect_to @user
    end
  end

  def destroy
    @wiki = current_user.wikis.find(params[:id])
    @user = User.find(@wiki.user_id)
    if @wiki.destroy
      flash[:notice] = "You have deleted Wiki '#{@wiki.title}'."
      redirect_to @user
    else
      flash[:error] = "There was an error in the process. Please try it again."
      redirect_to @user
    end
  end

  private

  def post_params
    params.require(:wiki).permit(:title, :body, :public)
  end
   
end
