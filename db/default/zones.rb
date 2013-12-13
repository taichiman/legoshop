russia = Spree::Zone.create!(name: "Россия", description: "Российская федерация")
russia.zone_members.create!(zoneable: Spree::Country.find_by!(name: "Россия"))


