# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  def daily_digest
    product = Product.joins(:users).first
    NotificationMailer.daily_digest(product.users.first.id)
  end
end
