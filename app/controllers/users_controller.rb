class UsersController < ApplicationController
  respond_to :html, :js

  def index
  end

  def show
    @title = "My Wikis"
    @wikis = current_user.created_wikis
    @new_wiki = Wiki.new
  end

  def shared
    @title = "Wikis Shared with Me" 
    @wikis = current_user.wikis.where.not(user_id: current_user.id)
    @new_wiki = Wiki.new
    render :show
  end

end
