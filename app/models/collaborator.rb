class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki

  #defining getter method for the attribute created
  def user_name
    if self.user
      self.user.user_name
    end
  end

  #setter method syntax for the attribute created
  def user_name=(value)
    user = User.where(:user_name => value).first
    self.user_id = user.id
  end
end
