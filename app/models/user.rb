class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :role, presence: true       
  enum role: {tenant: 0, landlord: 1}
  has_one :landlord
  has_one :tenant
  has_many :properties  
  has_many :requests 
  has_many :purchases
  has_many :notifications

  after_create :send_admin_mail
  def send_admin_mail
    UserMailer.welcome_email(self).deliver_later
  end

end
