class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
    @date = Date.today
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
    result = []
    @vendors.each do |vendor|
      if vendor.inventory.include?(item)
      result << vendor
      end
    end
    result
  end

  def sorted_item_list
    sorted = []
    @vendors.each do |vendor|
    vendor.inventory.keys.each do |item|
      sorted << item.name
      end
    end
    sorted.sort.uniq
  end

  def total_items(item_provided)
    total = 0
    @vendors.each do |vendor|
      vendor.inventory.keys.each do |item|
        if item_provided == item
          total += vendor.inventory[item_provided]
        else
          vendor.inventory[item_provided]
      end
    end
    end
    total
  end

  def total_inventory
    final_result = {}
    @vendors.each do |vendor|
      vendor.inventory.keys.each do |item|
        second_hash = {}
        second_hash[:quantity] = total_items(item)
        second_hash[:vendors] = vendors_that_sell(item)
      final_result[item] = second_hash
      end
    end
    final_result
  end

  def overstocked_items
    overstocked = []
    @vendors.each do |vendor|
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
