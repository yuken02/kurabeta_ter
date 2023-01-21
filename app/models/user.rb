class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_many :tabs, dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  # def self.first_tab
  #   find_or_create_by!(name: 'タブ') do |tab|
  #     tab.user_id = current_user.id
  #   end
  # end


  # after_create do
  #   @tab_new = Tab.new
  #   @tab_new.name = 'タブ'
  #   @tab_new.user_id = current_user.id
  #   @tab_new.save
  # end


  protected
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.create(
        email: User.dumy_email(auth),
        provider: auth.provider,
        uid: auth.uid,
        password: Devise.friendly_token[0, 20],
        nickname: auth.info.nickname,
        image: auth.info.image
      )
    end
    user
  end


  private

  def self.dumy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
