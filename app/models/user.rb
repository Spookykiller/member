class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :fullname, presence: true, length: {in: 2..40}
  
  has_many :posts
  has_many :comments
  has_one :portfolio
end
