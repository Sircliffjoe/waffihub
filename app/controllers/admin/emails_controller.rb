module Admin
  class EmailsController < BaseController
    before_action :set_email, only: [:show]

    def index
      @page_title = "Email Messages"
      @emails = Email.order(created_at: :desc).paginate(page: params[:page], per_page: 20)
    end

    def show
      @page_title = "Email Message"
    end

    def new
      @page_title = "Send Email"
      @email = Email.new
      @contact_types = contact_types_for_filter
    end

    def create
      recipient_emails = parse_recipients(email_params[:recipients])
      contact_type = email_params[:contact_type] || "manual"
      
      if recipient_emails.empty?
        redirect_to admin_emails_path, alert: "No valid recipients provided."
        return
      end

      emails_created = []
      
      recipient_emails.each do |recipient|
        email_obj = Email.create(
          recipient_email: recipient[:email],
          recipient_name: recipient[:name],
          subject: email_params[:subject],
          body: email_params[:body],
          contact_type: contact_type,
          status: "sent",
          user_id: recipient[:user_id]
        )
        
        if email_obj.persisted?
          # Send the email
          send_email(email_obj)
          emails_created << email_obj
        end
      end

      if emails_created.any?
        redirect_to admin_emails_path, notice: "Email sent successfully to #{emails_created.count} recipient(s)."
      else
        redirect_to new_admin_email_path, alert: "Failed to send emails. Please try again."
      end
    end

    private

    def set_email
      @email = Email.find(params[:id])
    end

    def email_params
      params.require(:email).permit(:subject, :body, :recipients, :contact_type)
    end

    def parse_recipients(recipients_input)
      return [] if recipients_input.blank?
      
      emails = []
      recipients_input.split("\n").each do |line|
        line = line.strip
        next if line.blank?
        
        # Parse "Name <email@domain.com>" or just "email@domain.com"
        if line =~ /<(.+?)>$/
          email = $1.strip
          name = line.sub(/<.+?>$/, '').strip
        else
          email = line
          name = email
        end
        
        if email.match?(URI::MailTo::EMAIL_REGEXP)
          user_id = find_user_by_email(email)&.id
          emails << { email: email, name: name.presence || email, user_id: user_id }
        end
      end
      
      emails
    end

    def find_user_by_email(email)
      User.find_by(email: email) || 
      ProjectApplication.find_by(email: email) ||
      Enrollment.find_by(email: email) ||
      Booking.find_by(email: email)
    end

    def send_email(email_obj)
      # Send via SMTP
      begin
        mail = Mail.new(
          from: ApplicationMailer.default[:from],
          to: email_obj.recipient_email,
          subject: email_obj.subject,
          body: email_obj.body
        )
        mail.deliver
      rescue => e
        Rails.logger.error("Failed to send email: #{e.message}")
        email_obj.update(status: "failed")
      end
    end

    def contact_types_for_filter
      Email.contact_types.keys
    end
  end
end
