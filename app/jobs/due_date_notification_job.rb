class DueDateNotificationJob
  include Sidekiq::Job

  def perform
    BookLoan.where(status: 'checked_out', due_date: Date.tomorrow).each do |book_loan|
      UserMailer.due_date_notification_email(book_loan).deliver_now
    end
  end
end
