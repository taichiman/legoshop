# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to override the default site name.
  # config.site_name = "Spree Demo Site"
  config.show_only_complete_orders_by_default = false
  config.currency = "RUB"
  config.currency_decimal_mark = "."
  config.currency_symbol_position = "after"
  config.currency_sign_before_symbol = false
  config.currency_thousands_separator = ","
  config.display_currency = false
end

Spree.user_class = "Spree::User"
