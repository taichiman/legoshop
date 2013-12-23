
  # SQL (0.4ms)  INSERT INTO `spree_shipping_methods` (`admin_name`, `created_at`, `display_on`, `name`, `tracking_url`, `updated_at`) VALUES ('курьер', '2013-12-20 12:04:01', '', 'курьер', '', '2013-12-20 12:04:01')
  # SQL (0.5ms)  INSERT INTO `spree_calculators` (`calculable_id`, `calculable_type`, `created_at`, `type`, `updated_at`) VALUES (1, 'Spree::ShippingMethod', '2013-12-20 12:04:01', 'Spree::Calculator::Shipping::FlatPercentItemTotal', '2013-12-20 12:04:01')
  # SQL (0.4ms)  INSERT INTO `spree_shipping_method_categories` (`created_at`, `shipping_category_id`, `shipping_method_id`, `updated_at`) VALUES ('2013-12-20 12:04:01', 1, 1, '2013-12-20 12:04:01')
  #  (0.3ms)  INSERT INTO `spree_shipping_methods_zones` (`shipping_method_id`, `zone_id`) VALUES (1, 1)

Spree::Calculator.create({ 
  calculable_id: 1,
  calculable_type: 'Spree::ShippingMethod',  
  type: 'Spree::Calculator::Shipping::FlatPercentItemTotal'
})

Spree::ShippingMethodCategory.create({
  shipping_category_id: 1,
  shipping_method_id: 1
})

shipping_method = Spree::ShippingMethod.new({  
  admin_name: 'курьер',
  display_on: '',
  name: 'курьер',
  tracking_url: '',
})
  shipping_method.shipping_categories = Spree::ShippingCategory.where id = 1
  shipping_method.calculator = Spree::Calculator.find 1

  shipping_method.save

  # shipping_method = Spree::ShippingMethod.find 1

  # zone = shipping_method.zones.build({  
  #   admin_name: 'курьер',
  #   display_on: '',
  #   name: 'курьер',
  #   tracking_url: '',
  # })
  # shipping_method.shipping_categories = Spree::ShippingCategory.where id = 1
  # shipping_method.calculator = Spree::Calculator.find 1

  #TODO maybe add set Russian zone to shipment one or do it after deploy as usual by hand.

  sql = "INSERT INTO `spree_shipping_methods_zones` (`shipping_method_id`, `zone_id`) VALUES (1, 1)"
  ActiveRecord::Base.connection.execute(sql) 

  # shipping_method = Spree::ShippingMethod.first

  # shipping_method = zone.create
#   s.zone_ids = [1]
#   s.save
# p s.errors

#   z.shipping_method_id_ids = [1]
#   z.save
# p z.errors