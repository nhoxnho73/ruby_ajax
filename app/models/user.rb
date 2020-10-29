class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  has_many :movies

  has_many :clients
  has_many :appointments
  has_many :locations
  
  def upcoming_appointments
    appointments.order(appointment_time: :desc).select{ |a| a.appointment_time > (DateTime.now) }
  end
end
