class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki

  validates :user_id, 
            :presence => {:message => "does not exist."},
            :uniqueness => {:scope => :wiki_id, :message => "already is a collaborator." }

  validates :wiki_id, 
            :presence => {:message => "does not exist."}

  

  #defining getter method for the attribute created
  def user_name
    if self.user
      self.user.user_name
    end
  end

  #setter method syntax for the attribute created
  def user_name=(value)
    if user = User.where(:user_name => value).first
      self.user_id = user.id
    end
  end
  
end
