class UsersController < ApplicationController
  def index
  end

  def show
    @wikis = User.find(params[:id]).wikis.all
    @new_wiki = Wiki.new
  end


end
