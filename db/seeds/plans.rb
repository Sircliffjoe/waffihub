Plan.destroy_all

plans = [
  { 
    name: "Daily Access", 
    price: 4000.0, 
    interval: "/day", 
    features: ["Dedicated Desk", "High-speed Internet", "Stable Power", "Access to Meeting Room"], 
    highlight: false 
  },
  { 
    name: "Weekly Access", 
    price: 20000.0, 
    interval: "/week", 
    features: ["Private Desk Space", "Unlimited Starlink", "VIP Lounge Access", "Networking Events"], 
    highlight: true 
  },
  { 
    name: "Monthly Access", 
    price: 50000.0, 
    interval: "/mo", 
    features: ["Business Address", "All Access Pass", "Dedicated Support", "Projector & Equipment"], 
    highlight: false 
  }
]

plans.each do |plan_attrs|
  Plan.create!(plan_attrs)
end

puts "Seeded #{Plan.count} pricing plans successfully."
