# db/seeds/shebuilds_project.rb
puts "Seeding SheBuilds project..."

shebuilds = Project.find_or_initialize_by(name: "SheBuilds Niger Delta")

shebuilds.assign_attributes(
  client: "WaffiHub & P.O.F",
  tagline: "Empowering the Riverine Communities",
  hero_description: "A practical, community-based digital skills intensive designed exclusively for women in the riverine heart of Delta State.",
  duration: "8 Weeks",
  format: "Community-Based",
  reach: "8 Communities/Year",
  cost: "Free to Participants",
  about_description: "Closing the Digital Gap, One Community at a Time.\nWomen in riverine Delta communities are talented and entrepreneurial, but often excluded from the digital economy due to location and stereotypes.",
  problem: "<ul><li>Training delivered inside the community (Schools, Halls, Churches).</li><li>Primarily using tools women already have — smartphones.</li><li>Free of charge, including data and transport stipends.</li></ul>",
  about_quote: "We are not bringing the digital world to your community. We are helping your community take its rightful place in it.",
  curriculum_title: "Earning-Focused Tracks",
  curriculum_description: "Every track is designed around a single question: 'How will this help me earn money and improve my standard of living?'",
  tracks: [
    { 
      "title" => "AI-Powered Income", 
      "desc" => "Generate business content, customer messages, and offer research services using no-code AI tools.",
      "icon" => "cpu"
    },
    { 
      "title" => "Social Media Mastery", 
      "desc" => "Manage WhatsApp, Facebook, and Instagram professionally and offer management services to local businesses.",
      "icon" => "share"
    },
    { 
      "title" => "WhatsApp Commerce", 
      "desc" => "Set up WhatsApp Business, catalogue products, and transition your business from offline to online.",
      "icon" => "chat-left-text"
    },
    { 
      "title" => "Digital Foundations", 
      "desc" => "Master internet use, email setup, and online safety while creating simple designs using Canva on your phone.",
      "icon" => "phone"
    }
  ],
  timeline_title: "Community-First Journey",
  timeline_description: "We do nothing without your blessing and your partnership. Here is our process.",
  timeline_steps: [
    { "phase" => "Engagement", "label" => "Weeks 0", "desc" => "Consultation with community leaders, women group leaders, and representatives." },
    { "phase" => "Foundations", "label" => "Weeks 1-5", "desc" => "Hands-on training, smartphone setup, and guided digital practice." },
    { "phase" => "Application", "label" => "Weeks 6-8", "desc" => "Real-life application through income-generating projects and business digital tools." },
    { "phase" => "Graduation", "label" => "Demo Day", "desc" => "Community Demo Day, certificate presentation, and alumni network on-boarding." }
  ],
  partnership_title: "Partner for Impact",
  partnership_description: "We are looking for partner communities to host SheBuilds cohorts of 40–60 women. To bring this programme to your community, we ask for support in venue access and mobilization.",
  partnership_bullets: [
    "Recognised & Branded Certificates of Completion.",
    "Ongoing post-programme support through WaffiHub network.",
    "Recognition as a SheBuilds Partner Community."
  ]
)

shebuilds.save!

# Attach the main image (we will use the local asset `app/assets/images/shebuilds.jpg`)
image_path = Rails.root.join('app', 'assets', 'images', 'shebuilds.jpg')
if File.exist?(image_path)
  shebuilds.main_image.attach(io: File.open(image_path), filename: 'shebuilds.jpg', content_type: 'image/jpeg')
end

puts "SheBuilds project seeded successfully!"
