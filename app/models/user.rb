class User < ApplicationRecord
  validates :name, presence: true
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :age, presence: true,
                  numericality: { greater_than: 0 }
end
