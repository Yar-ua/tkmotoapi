# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable
         # :confirmable
  include DeviseTokenAuth::Concerns::User

  has_many :bikes, dependent: :destroy
  has_one :user_config, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: {message: 'Current email already exists, try another'}
  validates :name, uniqueness: {message: 'Current name already exists, try another'}
  
end
