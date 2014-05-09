class WelcomeController < ApplicationController
  def index
    #pulling most recent public wikis and displaying titles
    @wikis = Wiki.all
  end
end
