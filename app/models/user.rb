class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :collaborators
  has_many :wikis, through: :collaborators

  has_many :created_wikis, class_name: "Wiki"
  
  def has_authority_to_delete_collaborators?
    raise
  end
end
