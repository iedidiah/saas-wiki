class WelcomeController < ApplicationController
  def index
    #pulling most recent public wikis and displaying titles
    @wikis = Wiki.where(public: true)
  end
end
