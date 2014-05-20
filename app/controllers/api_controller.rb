class ApiController < ApplicationController


  def usernames
    render json: User.where("id != #{current_user.id}").pluck(:user_name) 
  end

end
