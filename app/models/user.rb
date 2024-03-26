class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         enum role: [:admin, :student, :teacher]

  has_many :fees

  def send_devise_notification(notification, *args)
    DeviseMailerWorker.perform_async(notification, self.class.name, id, *args)
  end

end
