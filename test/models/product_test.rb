require 'test_helper'

class ProductTest < ActiveSupport::TestCase
   fixtures :products
  # test "the truth" do
   #  assert true
   #end
   test "product attributes must not be empty" do
      product = Product.new
      assert product.invalid?
      assert product.errors[:title].any?
      assert product.errors[:description].any?
      assert product.errors[:price].any?
      assert product.errors[:image_url].any?
   end 
  
   test "product price must be positive" do 
      product = Product.new(title: "My Book Title",
                              description: "yyy",
                              image_url:     "zzz.jpg")
      product.price = -1
      assert product.invalid?
      assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join('; ')
      product.price = 0
      assert product.invalid?
      assert_equal "must be greater than or equal to 0.01",
      product.price = 1
      product.errors[:price].join('; ')
      assert product.valid?
   end
   
   def new_product(image_url) 
     Product.new(title: "My Book Title",
     description:    "yyy",
     price: 1,
     image_url: image_url)
   end 
   test "image_url" do
     ok = %w{fred.gif fred.png fred.jpg FRED.JPG fred.Jpg http://a.b.c/y/z/fred.jpg}
     bad = %w{fred.doc fred.more}
     
     ok.each do |name|
       assert new_product(name).valid?, "#{name} shouldn't be invalid" # не должно быть неприемлемым
     end
     
     bad.each do |name| 
       assert new_product(name).invalid?, "#{name} shouldn't be valid" # должно быть неприемлемым
     end
 
   end
    test "product is valid without unique test" do
         product = Product.new(title: products(:ruby).title,
            description:    "yyy",
            price:        1,
            image_url:    "fred.gif")
         assert !product.save
         assert_equal "has already been taken", product.errors[:title].join('; ')
    end

    test " product is not valid without a unique title - i18n" do 
      product = Product.new(title: products(:ruby).title,
                            description: "yyy",
                            price:        1,
                            image_url:    "fred.gif")
        assert !product.save
        assert_equal I18n.translate('activerecord.errors.messages.taken'),
            product.errors[:title].join('; ')
    end
   
  test "product title length must be greater then 10" do
    product = Product.new(description: "yyy",
                          price:        1,
                          image_url:    "fred.gif")
    product.title = "111111111"
    #assert product.invalid?
    #assert_equal "title length must be greater than or equal to 10",
    #product.errors[:title].join('; ')
    #product.title = "2222222222"
    #assert product.invalid?
    #assert_equal "title length must be greater than or equal to 10",
    #product.errors[:title].join('; ')
    product.title = "33333333333"
    product.errors[:title].join('; ')
    assert product.valid?
  end
   
   
   
end
