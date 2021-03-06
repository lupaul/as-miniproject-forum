class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  has_many :groups
  has_many :topics, dependent: :destroy
  has_one :profile
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_topics, through: :likes, source: :topic
  has_many :photos
  has_many :store_topicships
  has_many :store_topics, through: :store_topicships, source: :topic

  def display_name
    email.split("@").first
  end

  def store!(topic)
    store_topics << topic
  end

  def unstore!(topic)
    store_topics.delete(topic)
  end

  def is_store_of?(topic)
    store_topics.include?(topic)
  end

  def admin?
    is_admin
  end

  def to_admin
    self.update_columns(is_admin: true)
  end

  def to_normal
    self.update_columns(is_admin: false)
  end

  def self.from_omniauth(auth)
   # Case 1: Find existing user by facebook uid
   user = User.find_by_fb_uid( auth.uid )
   if user
    #  byebug
      user.fb_token = auth.credentials.token
      #user.fb_raw_data = auth
      user.save!
     return user
   end

   # Case 2: Find existing user by email
   existing_user = User.find_by_email( auth.info.email )
   if existing_user
     existing_user.fb_uid = auth.uid
     existing_user.fb_token = auth.credentials.token
     #existing_user.fb_raw_data = auth
     existing_user.save!
     return existing_user
   end

   # Case 3: Create new password
   user = User.new
   user.fb_uid = auth.uid
   user.fb_token = auth.credentials.token
   user.email = auth.info.email
   user.password = Devise.friendly_token[0,20]
   #user.fb_raw_data = auth
   user.save!
   return user
 end

  # def self.from_omniauth(auth)
  #
  #   #Rails.logger.info auth.inspect
  #   # Rails.logger.info "========="  #這是如果有錯的話可以用來檢查
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #
  #       user.email = auth.info.email
  #
  #       user.password = Devise.friendly_token[0,20]
  #       user.name = auth.info.name
  #
  #       user.image = auth.info.image
  #   end
  #
  # end

end
