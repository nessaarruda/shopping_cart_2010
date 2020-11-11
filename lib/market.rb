class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def date
    Date.today.strftime("%d/%m/%Y")
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor if vendor.inventory.include?(item)
    end
  end

  def sorted_item_list
    @vendors.flat_map do |vendor|
    vendor.inventory.keys.map do |item|
      item.name
      end
    end.uniq
  end

  def total_items(item_provided)
    total = 0
    @vendors.each do |vendor|
      vendor.inventory.keys.each do |item|
        total += vendor.inventory[item_provided] if item_provided == item
      end
    end
    total
  end

  def total_inventory
    total_inventory_hash = {}
    @vendors.each do |vendor|
      vendor.inventory.keys.each do |item|
        item_hash = {}
        item_hash[:quantity] = total_items(item)
        item_hash[:vendors] = vendors_that_sell(item)
        total_inventory_hash[item] = item_hash
      end
    end
    total_inventory_hash
  end

  def overstocked_items
    overstocked = []
    @vendors.find_all do |vendor|
      vendor.inventory.keys.each do |item|
        if vendors_that_sell(item).count >= 2 && total_items(item) >= 50
          overstocked << item
        end
      end
    end
    overstocked.uniq
  end

  def is_enough?(item, quantity_provided)
    quantity = total_items(item)
    quantity >= quantity_provided
  end

  def sell(item, quantity_provided)
    if !is_enough?(item, quantity_provided)
      false
    else
      quantity = quantity_provided
      @vendors.each do |vendor|
        while vendor.inventory[item] > 0 && quantity > 0
          vendor.inventory[item] -= 1
          quantity -= 1
        end
      end
      true
    end
  end
end
