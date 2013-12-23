Spree.config do |config|
  config.allow_ssl_in_production = false
  config.always_include_confirm_step = true
  config.show_only_complete_orders_by_default = false

  config.currency = "RUB"
  config.currency_decimal_mark = "."
  config.currency_symbol_position = "after"
  config.currency_sign_before_symbol = false
  config.currency_thousands_separator = ","
  config.display_currency = false
  config.track_inventory_levels = false
end

Spree.user_class = "Spree::User"
