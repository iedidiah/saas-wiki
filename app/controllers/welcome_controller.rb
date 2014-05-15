class WelcomeController < ApplicationController

  respond_to :html, :js

  def index
    #pulling most recent public wikis and displaying titles
    @wikis = Wiki.where(public: true)
  end
end
