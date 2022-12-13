class Book < ApplicationRecord
  #has_one_attached :book  
  belongs_to :user
  
  #has_many :favorites, dependent: :destroy
  #has_many :post_comments, dependent: :destroy

  
  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: { maximum: 200 }
  
  
  
end

