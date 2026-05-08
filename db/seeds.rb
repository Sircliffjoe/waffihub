# Seed Data for WaffiHub CMS
require 'open-uri'

# Create Admin User
admin = User.find_or_initialize_by(email: 'admin@waffihub.ng')
admin.password = 'waffii@2020!!'
admin.password_confirmation = 'waffii@2020!!'
admin.admin = true
admin.save!
puts "Admin verified/updated: admin@waffihub.ng / waffii@2020!!"

# Programs with Images
programs_data = [
  { title: 'Software Development', price: 150000, duration: '12 Weeks', img_id: '1531482615713-2afd69097998' },
  { title: 'Data Analysis & Virtualization', price: 150000, duration: '8 Weeks', img_id: '1460925895917-afdab827c52f' },
  { title: 'UI/UX Design', price: 120000, duration: '8 Weeks', img_id: '1561070791322-9b761a09b305' },
  { title: 'WordPress Development', price: 100000, duration: '8 Weeks', img_id: '1461749280684-dccba630e2f6' },
  { title: 'Microsoft Office Suite', price: 80000, duration: '8 Weeks', img_id: '1498050108021-c5248f567118' },
  { title: 'Digital Marketing', price: 120000, duration: '8 Weeks', img_id: '1557838330-3209c73d8bf4' }
]

programs_data.each do |data|
  program = Program.find_or_create_by!(title: data[:title]) do |p|
    p.description = "This is a comprehensive #{data[:title]} program designed to take you from beginner to professional."
    p.price = data[:price]
    p.duration = data[:duration]
    p.mode = "Hybrid"
    p.instructor = "WaffiHub"
  end
  # Attach image
  begin
    unless program.main_image.attached?
      file = URI.open("https://images.unsplash.com/photo-#{data[:img_id]}?auto=format&fit=crop&q=80&w=800", "User-Agent" => "Mozilla/5.0")
      program.main_image.attach(io: file, filename: "#{data[:title].parameterize}.jpg", content_type: 'image/jpeg')
    end
  rescue => e
    puts "Could not attach image for #{data[:title]}: #{e.message}"
  end
end
puts "Programs seeded."

# Team Members
# TeamMember.destroy_all (Disabled for production safety)
team_data = [
  { 
    name: 'Paul Okoro', 
    role: 'CEO & Founder', 
    bio: 'A visionary leader with 15+ years in tech ecosystem building, dedicated to scaling Nigerian startups.', 
    img_id: '1560250097-0b93528c311a' 
  },
  { 
    name: 'Ettah Clifford', 
    role: 'Hub Manager', 
    bio: 'A results-driven full-stack engineer and ecosystem builder with a strong track record in managing innovation hubs and supporting early-stage startups.', 
    img_id: '1507003211169-0a1dd7228f2d' 
  },
  { 
    name: 'Jahsmine Aninta', 
    role: 'Head of Operations', 
    bio: 'A highly organized operations leader with deep experience in vocational training and program management.', 
    img_id: '1573496359142-b8d87734a5a2' 
  },
  { 
    name: 'Sophia Akpofure', 
    role: 'Community Manager', 
    bio: 'A dynamic community builder focused on fostering engagement, collaboration, and growth within the ecosystem.', 
    img_id: '1580489944761-15a19d654956' 
  }
]

team_data.each do |data|
  member = TeamMember.find_or_create_by!(name: data[:name]) do |m|
    m.role = data[:role]
    m.bio = data[:bio]
  end
  begin
    file = URI.open("https://images.unsplash.com/photo-#{data[:img_id]}?auto=format&fit=crop&q=80&w=400", "User-Agent" => "Mozilla/5.0")
    member.image.attach(io: file, filename: "#{data[:name].parameterize}.jpg", content_type: 'image/jpeg')
  rescue => e
    puts "Could not attach team image: #{e.message}"
  end
end
puts "Team Members seeded."

# Projects for Impact (Demo Content)
# Project.destroy_all (Disabled for production safety)
projects_data = [
  { name: 'Youth Digital Literacy Drive', client: 'Delta State Government', img_id: '1509062522246-37399d4a414f' },
  { name: 'Startup Incubation Cohort 2025', client: 'WaffiHub Ventures', img_id: '1552664730-d307ca884978' },
  { name: 'Tech In Schools Initiative', client: 'Private Donors', img_id: '1503676260728-1c00da096a0b' }
]

projects_data.each do |data|
  project = Project.find_or_create_by!(name: data[:name]) do |p|
    p.client = data[:client]
  end
  begin
    file = URI.open("https://images.unsplash.com/photo-#{data[:img_id]}?auto=format&fit=crop&q=80&w=800", "User-Agent" => "Mozilla/5.0")
    project.main_image.attach(io: file, filename: "#{data[:name].parameterize}.jpg", content_type: 'image/jpeg')
  rescue => e
    puts "Could not attach project image: #{e.message}"
  end
end
puts "Projects seeded."

# Partnerships (5 logos)
# Partnership.destroy_all (Disabled for production safety)
partners_data = [
  { name: 'Google for Startups', url: 'https://google.com' },
  { name: 'Microsoft Africa', url: 'https://microsoft.com' },
  { name: 'Flutterwave', url: 'https://flutterwave.com' },
  { name: 'Paystack', url: 'https://paystack.com' },
  { name: 'Delta State Government', url: 'https://deltastate.gov.ng' }
]

partners_data.each do |data|
  Partnership.find_or_create_by!(name: data[:name]) do |p|
    p.link = data[:url]
  end
end
puts "Partnerships seeded."

# Posts with Images
# Post.destroy_all (Disabled for production safety)
3.times do |i|
  title = "WaffiHub News Item #{i+1}"
  post = Post.find_or_create_by!(title: title) do |p|
    p.content = "Stay tuned for major updates coming to the Delta tech ecosystem. WaffiHub is leading the charge."
    p.published_at = Time.current
    p.slug = "news-item-#{i+1}"
  end
  begin
    file = URI.open("https://images.unsplash.com/photo-1526628953301-3e589a6a8b74?auto=format&fit=crop&q=80&w=800", "User-Agent" => "Mozilla/5.0")
    post.featured_image.attach(io: file, filename: "news-#{i}.jpg", content_type: 'image/jpeg')
  rescue => e
    puts "Could not attach news image: #{e.message}"
  end
end
puts "Posts seeded."
