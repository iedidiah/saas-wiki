class WikisController < ApplicationController
  def index
    @wikis = Wiki.where(public: true)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
  end

  def edit
  end
end