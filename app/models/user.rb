class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, 
         :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
 
  has_many :questions
  has_many :tests
  has_many :answers, through: :tests
  has_reputation :votes, source: {reputation: :votes, of: :questions}, aggregated_by: :sum
  
 def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

   unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        username: auth.info.name,
        password: Devise.friendly_token[0, 20]
      )
    end

    user
  end

  def self.new_with_session(params, session)
   super.tap do |user|
    if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
       user.email = data["email"] if user.email.blank?
     end
   end
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
 end
