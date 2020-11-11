require './lib/item'
require './lib/vendor'
require './lib/market'

@item1 = Item.new({name: 'Peach', price: "$0.75"})
@vendor = Vendor.new("Rocky Mountain Fresh")
@market = Market.new("South Pearl Street Farmers Market")

puts "Just wanted to practice creating a runner"
