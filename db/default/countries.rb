Spree::Country.create!([
  { name: "Россия", iso3: "RUS", iso: "RU", iso_name: "RUSSIAN FEDERATION", numcode: "643", states_required: true }
])
Spree::Config[:default_country_id] = Spree::Country.find_by(name: "Россия").id