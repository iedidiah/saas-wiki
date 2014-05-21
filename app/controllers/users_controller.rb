class UsersController < ApplicationController
  respond_to :html, :js

  def index
  end

  def show
    @title = "My Wikis"
    #this pulls all wikis that the user is a collaborator for
    #@wikis = User.find(current_user.id).wikis.all
    #this pulls only the wikis that the user is the creator of 
    @wikis = User.find(current_user.id).wikis.where(user_id: current_user.id)
    @new_wiki = Wiki.new
  end

  def shared
    @title = "Wikis Shared with Me" 
    @wikis = current_user.wikis.where.not(user_id: current_user.id)
    @new_wiki = Wiki.new
    render :show
  end

end
