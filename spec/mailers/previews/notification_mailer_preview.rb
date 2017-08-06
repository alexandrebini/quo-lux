# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  def product_update
    product = Product.joins(:users).first
    NotificationMailer.product_update(product.id, product.users.first.id)
  end
end
