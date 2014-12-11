class Product < ActiveRecord::Base
  validates :title, :description, :price, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to:0.01}
  validates :title, :uniqueness => {
    message: "UNIQUE!!!"
  }
  validates :image_url, allow_blank: true, format: {
      with: %r{\.(gif|jpg|png)}i,#/\.(gif|jpg|png)/i, 
      message: 'URL должен указывать на изображение формата GIF, JPG или PNG.'
  }
  validates :title, :length => {:minimum => 10 }
end
