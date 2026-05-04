# Seed Data for WaffiHub CMS
require 'open-uri'

# Create Admin User
admin = User.find_or_create_by!(email: 'admin@waffihub.ng') do |u|
  u.password = 'waffii@2020!!'
  u.password_confirmation = 'waffi@2020!!'
  u.admin = true
end
puts "Admin created: admin@waffihub.ng / waffii@2020!!"

# Programs with Images
programs_data = [
  { title: 'Software Development', price: 150000, duration: '12 Weeks', img_id: '1587629984606-2531ada03976' },
  { title: 'Data Analysis & Virtualization', price: 150000, duration: '8 Weeks', img_id: '1551288049-bbda38a10ad5' },
  { title: 'UI/UX Design', price: 120000, duration: '8 Weeks', img_id: '1586717791821-3f44a563eb4c' },
  { title: 'WordPress Development', price: 100000, duration: '8 Weeks', img_id: '1587629984606-2531ada03976' },
  { title: 'Microsoft Office Suite', price: 80000, duration: '8 Weeks', img_id: '1551288049-bbda38a10ad5' },
  { title: 'Digital Marketing', price: 120000, duration: '8 Weeks', img_id: '1586717791821-3f44a563eb4c' }
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
      file = URI.open("https://images.unsplash.com/photo-#{data[:img_id]}?auto=format&fit=crop&q=80&w=800")
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
    img_id: '1560298814-14f964a440b2' 
  },
  { 
    name: 'Ettah Clifford', 
    role: 'Hub Manager', 
    bio: 'A results-driven full-stack engineer and ecosystem builder with a strong track record in managing innovation hubs and supporting early-stage startups. Clifford combines technical expertise with strategic thinking to design impactful programs, mentor emerging talent, and drive digital transformation across communities.', 
    img_id: '1500648767-99cd02c8944d' 
  },
  { 
    name: 'Jahsmine Aninta', 
    role: 'Head of Operations', 
    bio: 'A highly organized operations leader with deep experience in vocational training and program management. Jahsmine ensures the seamless delivery of training initiatives by optimizing processes, coordinating resources, and maintaining high standards that empower learners with practical, industry-relevant skills.', 
    img_id: '1494790108377-be9c29b29330' 
  },
  { 
    name: 'Sophia Akpofure', 
    role: 'Community Manager', 
    bio: 'A dynamic community builder focused on fostering engagement, collaboration, and growth within the ecosystem. Sophia specializes in creating meaningful experiences for members, managing stakeholder relationships, and driving initiatives that strengthen community participation and long-term impact.', 
    img_id: '1500648767-99cd02c8944d' 
  }
]

team_data.each do |data|
  member = TeamMember.find_or_create_by!(name: data[:name]) do |m|
    m.role = data[:role]
    m.bio = data[:bio]
  end
  begin
    file = URI.open("https://images.unsplash.com/photo-#{data[:img_id]}?auto=format&fit=crop&q=80&w=400")
    member.image.attach(io: file, filename: "#{data[:name].parameterize}.jpg", content_type: 'image/jpeg')
  rescue => e
    puts "Could not attach team image: #{e.message}"
  end
end
puts "Team Members seeded."

# Projects for Impact (Demo Content)
# Project.destroy_all (Disabled for production safety)
projects_data = [
  { name: 'Youth Digital Literacy Drive', client: 'Delta State Government', img_id: '1531482615713-2afd69097998' },
  { name: 'Startup Incubation Cohort 2025', client: 'WaffiHub Ventures', img_id: '1552664730-d307ca884978' },
  { name: 'Tech In Schools Initiative', client: 'Private Donors', img_id: '1509062522246-37399d4a414f' }
]

projects_data.each do |data|
  project = Project.find_or_create_by!(name: data[:name]) do |p|
    p.client = data[:client]
  end
  begin
    file = URI.open("https://images.unsplash.com/photo-#{data[:img_id]}?auto=format&fit=crop&q=80&w=800")
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
    file = URI.open("https://images.unsplash.com/photo-1526628953301-3e589a6a8b74?auto=format&fit=crop&q=80&w=800")
    post.featured_image.attach(io: file, filename: "news-#{i}.jpg", content_type: 'image/jpeg')
  rescue => e
    puts "Could not attach news image: #{e.message}"
  end
end
puts "Posts seeded."
