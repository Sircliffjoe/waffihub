FULL AI AGENT PROMPT (WAFFIHUB CMS WEBSITE)
🧠 PROJECT OVERVIEW

You are building a production-ready CMS-driven website for:

WaffiHub Limited – a tech innovation hub located in Warri, Delta State, Nigeria.

The platform should function as:

A content management system (CMS)
A training & program platform (with payments)
A service showcase website
A community & innovation hub portal
⚙️ TECH STACK REQUIREMENTS

Build using:

Ruby on Rails (latest stable)
PostgreSQL
Importmaps (NO Node.js)
Hotwire (Turbo + Stimulus)
Bootstrap 5 (UI framework)
Active Storage (for media uploads)
🎨 DESIGN REQUIREMENTS
Theme:
Primary Color: Blueish-gray (#2F4F4F / #34495E style)
Secondary: Light gray / white
Accent: Soft blue or orange for CTAs
Style:
Modern, clean, tech-focused
Inspired by:
Stripe
Andela
UX:
Smooth transitions (Turbo)
Responsive (mobile-first)
Card-based layouts
Subtle animations (Stimulus)
🧩 CORE FEATURES
1. CMS SYSTEM (VERY IMPORTANT)

Admin should be able to:

Create/edit/delete:
Programs
Services
Events
Blog posts (News)
Team members
Partnerships
Projects (Our Work)
Upload images/files
Publish/unpublish content
2. PAYMENT SYSTEM 💳

Implement payment for:

Training programs
Services (optional booking/payment)
Requirements:
Integrate:
Paystack OR Flutterwave
Features:
Pay for course
Payment confirmation
Store transaction records
Link payment to user/program
3. PROGRAM / COURSE SYSTEM

Each program should include:

Title
Description
Price
Duration
Mode (Online / Physical)
Instructor (optional)
CTA: Enroll & Pay
4. SERVICES SYSTEM

Categories:

Co-working and Training
Startups/SMEs Business Services
Private and Public Sector Innovation

Each service:

Title
Description
Pricing (optional)
CTA (Request / Pay)
5. BLOG / NEWS SYSTEM
Title
Content
Featured image
Publish date
Slug-based URLs
6. TEAM / PEOPLE
Name
Role
Bio
Image
7. PARTNERSHIPS
Partner logo
Description
Link
8. PROJECTS / OUR WORK
Project name
Client
Problem
Solution
Outcome
Images
9. CONTACT SYSTEM
Contact form (store inquiries)
Email notifications (optional)
🧭 SITE STRUCTURE (IMPORTANT)

Merge and clean the provided menus into this structure:

MAIN NAVIGATION
1. Home
2. About
History
Our People (Team)
Partnerships
3. Services
Co-working and Training
Startups/SMEs Business Services
Private and Public Sector Innovation
4. Programs
Enspire Program (highlighted flagship program)
Other Trainings
5. Our Work
6. Impact
7. News
8. Contact / Get in Touch
FOOTER (Quick Links)
Home
Services
Impact
Our Work
Our Team
Contact
🏗️ DATABASE MODELS

Create models for:

User (optional basic auth)
Program
Enrollment
Payment
Service
Project
Post (News)
TeamMember
Partnership
Inquiry
🔐 ADMIN PANEL

Use:

ActiveAdmin

Admin should:

Manage all CMS content
View payments
View enrollments
🎨 UI COMPONENTS TO BUILD
Navbar (sticky)
Hero sections
Cards (programs, services, posts)
Testimonials section
CTA sections
Footer (rich with links)
⚡ HOTWIRE USAGE

Use Turbo + Stimulus for:

Form submissions (no reload)
Flash messages
Dynamic filtering (programs/events)
Interactive UI components
💳 PAYMENT FLOW
User selects program
Clicks “Enroll”
Redirect to payment (Paystack/Flutterwave)
On success:
Save payment record
Create enrollment
Show success page
📱 RESPONSIVENESS

Ensure:

Mobile-first layout
Clean tablet/desktop scaling
📈 SEO BASICS
Meta tags
Clean URLs
Blog optimization
🚀 DEPLOYMENT

Prepare for deployment on:

Render / Railway / VPS
🎯 FINAL EXPECTATION

Deliver a fully working CMS-powered website with:

Clean UI
Admin dashboard
Payment system
Structured content
Scalable architecture
🔥 BONUS (IF POSSIBLE)
Testimonials section
Newsletter signup
Event integration (future-ready for your platform)
🧠 FINAL INSTRUCTION TO AGENT

Build this as a production-ready application, not a prototype.
Code should be clean, modular, and scalable.
Prioritize usability, clarity, and performance.

💡 PRO TIP (FOR YOU)

When you paste this prompt into an AI builder:

👉 Start with:

“Break this into tasks and execute step-by-step.”