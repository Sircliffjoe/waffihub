# Seed Data for WaffiHub CMS
require 'open-uri'

# Create Admin User
admin = User.find_or_create_by!(email: 'admin@waffihub.com') do |u|
  u.password = 'password123'
  u.password_confirmation = 'password123'
  u.admin = true
end
puts "Admin created: admin@waffihub.com / password123"

# Programs with Images
programs_data = [
  { title: 'Software Engineering Boot Camp', price: 150000, duration: '12 Weeks', img_id: '1587629984606-2531ada03976' },
  { title: 'Data Science Masterclass', price: 180000, duration: '10 Weeks', img_id: '1551288049-bbda38a10ad5' },
  { title: 'UI/UX Design Intensive', price: 120000, duration: '8 Weeks', img_id: '1586717791821-3f44a563eb4c' }
]

programs_data.each do |data|
  program = Program.find_or_create_by!(title: data[:title]) do |p|
    p.description = "This is a comprehensive #{data[:title]} program designed to take you from beginner to professional."
    p.price = data[:price]
    p.duration = data[:duration]
    p.mode = "Hybrid"
    p.instructor = "WaffiHub Expert"
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
TeamMember.destroy_all
team_data = [
  { name: 'Emeka Obi', role: 'CEO & Founder', bio: 'A visionary leader with 15+ years in tech ecosystem building. dedicated to scaling Nigerian startups.', img_id: '1560298814-14f964a440b2' },
  { name: 'Sarah Ahmed', role: 'Head of Programs', bio: 'Expert in vocational training and talent development, ensuring high-quality education for all our students.', img_id: '1494790108377-be9c29b29330' },
  { name: 'Ettah Clifford', role: 'Lead Developer', bio: 'Full-stack engineer passionate about mentorship and building scalable digital solutions.', img_id: '1500648767-99cd02c8944d' }
]

team_data.each do |data|
  member = TeamMember.create!(data.slice(:name, :role, :bio))
  begin
    file = URI.open("https://images.unsplash.com/photo-#{data[:img_id]}?auto=format&fit=crop&q=80&w=400")
    member.image.attach(io: file, filename: "#{data[:name].parameterize}.jpg", content_type: 'image/jpeg')
  rescue => e
    puts "Could not attach team image: #{e.message}"
  end
end
puts "Team Members seeded."

# Projects for Impact (Demo Content)
Project.destroy_all
projects_data = [
  { name: 'Youth Digital Literacy Drive', client: 'Delta State Government', img_id: '1531482615713-2afd69097998' },
  { name: 'Startup Incubation Cohort 2025', client: 'WaffiHub Ventures', img_id: '1552664730-d307ca884978' },
  { name: 'Tech In Schools Initiative', client: 'Private Donors', img_id: '1509062522246-37399d4a414f' }
]

projects_data.each do |data|
  project = Project.create!(name: data[:name], client: data[:client])
  begin
    file = URI.open("https://images.unsplash.com/photo-#{data[:img_id]}?auto=format&fit=crop&q=80&w=800")
    project.main_image.attach(io: file, filename: "#{data[:name].parameterize}.jpg", content_type: 'image/jpeg')
  rescue => e
    puts "Could not attach project image: #{e.message}"
  end
end
puts "Projects seeded."

# Partnerships (5 logos)
Partnership.destroy_all
partners_data = [
  { name: 'Google for Startups', url: 'https://google.com' },
  { name: 'Microsoft Africa', url: 'https://microsoft.com' },
  { name: 'Flutterwave', url: 'https://flutterwave.com' },
  { name: 'Paystack', url: 'https://paystack.com' },
  { name: 'Delta State Government', url: 'https://deltastate.gov.ng' }
]

partners_data.each do |data|
  Partnership.create!(name: data[:name]) do |p|
    p.link = data[:url]
  end
end
puts "Partnerships seeded."

# Posts with Images
Post.destroy_all
3.times do |i|
  post = Post.create!(title: "WaffiHub News Item #{i+1}") do |p|
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
