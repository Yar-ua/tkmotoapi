# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  include DeviseTokenAuth::Concerns::User

  validates :email, uniqueness: {message: 'Current email already exists, try another'}
  validates :name, uniqueness: {message: 'Current name already exists, try another'}
  validates :name, :email, presence: {messaage: 'Value must be present'}
  
end
