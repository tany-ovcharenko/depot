class Product < ActiveRecord::Base
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  # убеждаемся в отсутствии товарных позиций, ссылающихся на данный товар
  def ensure_not_referenced_by_any_line_item
      if line_items.empty?
          return true
      else
          errors.add(:base, 'существуют товарные позиции')
          return false
      end
  end
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
