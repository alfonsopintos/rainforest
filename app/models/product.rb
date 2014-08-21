class Product < ActiveRecord::Base
	validates :description, :name, :details, presence: true
	
	validates :price_in_cents,numericality: {only_integer: true, greater_than: 0} 

	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  	validates_attachment :avatar, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

	def formatted_price
		price_in_dollars = price_in_cents.to_f / 100
		sprintf("%.2f", price_in_dollars)
	end

	has_many :reviews
	
	def to_s
		"#{name} - (#{formatted_price})"
	end


end
