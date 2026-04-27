class Admin::DashboardController < Admin::BaseController
  def index
    @stats = {
      programs: Program.count,
      services: Service.count,
      posts: Post.count,
      projects: Project.count,
      team: TeamMember.count,
      partners: Partnership.count,
      inquiries: Inquiry.count,
      enrollments: Enrollment.count
    }
    @recent_inquiries = Inquiry.order(created_at: :desc).limit(5)
    @recent_enrollments = Enrollment.includes(:user, :program).order(created_at: :desc).limit(5)
  end
end
