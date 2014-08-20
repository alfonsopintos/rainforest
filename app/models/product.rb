class Product < ActiveRecord::Base
	validates :description, :name, :details, presence: true
	
	validates :price_in_cents,numericality: {only_integer: true, greater_than: 0} 

	def formatted_price
		price_in_dollars = price_in_cents.to_f / 100
		sprintf("%.2f", price_in_dollars)
	end

	has_many :reviews

	def to_s
		"#{name} - (#{formatted_price})"
	end
end
