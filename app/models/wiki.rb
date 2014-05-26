class Wiki < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators 
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  after_create :add_creator_as_collaborator

  def editable_by?(user)
    user.paid || self.creator.user_name == user.user_name
  end

  def deletable_by?(user)
    self.creator.user_name == user.user_name
  end

  def accessible_by_current_user(user)
    if self.public
      true
    else
      if user == nil
        false
      else
        if Collaborator.where(wiki_id: self.id, user_id: user.id).count > 0
          true
        else
          false 
        end
      end
    end
  end

  def age
    time_ago_in_words(self.created_at)
  end

  def author
    self.creator.user_name
  end

  def public_status
    self.public ? "Public" : "Non-public"
  end

  def short_description
    "submitted #{self.age} ago by #{self.author}, #{self.public_status} Wiki"
  end

  private

 def add_creator_as_collaborator
   self.creator.collaborators.create(wiki: self)
 end 

end
