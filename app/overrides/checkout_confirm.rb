Deface::Override.new(
  :virtual_path => "spree/shared/_order_details",
  :remove => "div.row.steps-data > div.columns.omega.four, 
  div.row.steps-data > div[data-hook='order-bill-address'],
  div.columns.alpha.four:not([data-hook])",
  :name => "checkout_confirm"
)
