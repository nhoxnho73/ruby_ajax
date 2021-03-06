class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  has_many :movies
  has_many :rooms
  has_many :messages
  has_many :clients
  has_many :appointments
  has_many :locations
  
  delegate :movie_name, to: :movies

  def movie_director
    logger.debug("may hu roi")
    movies.all
    
  end

  def upcoming_appointments
    appointments.order(appointment_time: :desc).select{ |a| a.appointment_time > (DateTime.now) }
  end
end
