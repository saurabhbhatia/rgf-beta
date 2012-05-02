class User < ActiveRecord::Base
  has_many :authentications
  has_one :profile
  has_many :listings
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

has_many :friendships
has_many :friends, :through => :friendships
has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
has_many :inverse_friends, :through => :inverse_friendships, :source => :user

has_many :friends, :through => :friendships, :conditions => "status = 'accepted'"
has_many :requested_friends, :through => :friendships, 
                             :source => :friend, :conditions => "status = 'requested'", :order => :created_at
has_many :pending_friends, :through => :friendships,
                           :source => :friend, :conditions => "status = 'pending'", :order => :created_at
has_many :friendships, :dependent => :destroy

has_one :group


#  has_many :friendships
#  has_many :friends, :through => :friendships  
#  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
#  has_many :direct_friends, :through => :friendships, :conditions => "approved = true", :source => :friend
#  has_many :inverse_friends, :through => :inverse_friendships, :conditions => "approved = true", :source => :user

#  has_many :pending_friends, :through => :friendships, :conditions => "approved = false", :foreign_key => "user_id", :source => :user
#  has_many :requested_friendships, :class_name => "Friendship", :foreign_key => "friend_id", :conditions => "approved = false"

 # def friends
 #   direct_friends | inverse_friends
 # end
def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end

def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
  data = access_token.extra.raw_info
  if user = self.find_by_email(data.email)
    user
  else # Create a user with a stub password. 
    self.create!(:email => data.email, :password => Devise.friendly_token[0,20]) 
  end
end


end
