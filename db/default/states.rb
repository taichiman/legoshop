country = Spree::Country.find_by(name: 'Россия')

Spree::State.create!([
  { name: 'Омская', abbr: 'Ом', country: country },
])
