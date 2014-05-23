class Wiki < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  has_many :collaborators
  has_many :users, through: :collaborators 
  belongs_to :creator, class_name: "User", foreign_key: "user_id"

  def editable_by?(user)
    user.paid || self.creator.user_name == user.user_name
  end

  def deletable_by?(user)
    self.creator.user_name == user.user_name
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

end
