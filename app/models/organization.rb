class Organization < ActiveRecord::Base
  belongs_to :user
  has_many :plans, dependent: :destroy
  validates :name, presence: :true, length: {minimum: 6} 
  validates :description, presence: :true, length: {minimum: 11}
end
