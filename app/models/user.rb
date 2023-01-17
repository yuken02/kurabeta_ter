class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
end
