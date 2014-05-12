class WikisController < ApplicationController
  def index
    @wikis = Wiki.where(public: true)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
  end

  def create

  end

  def edit
  end

  private

  def post_params
    params.require(:wiki).permit(:title, :body)
  end
   
end
