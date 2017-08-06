class NotificationMailer < ApplicationMailer
  def product_update(product_id, user_id)
    @user = User.find_by(id: user_id)
    @product = Product.find_by(id: product_id)
    return if @product.blank? || @user.blank?
    mail(to: @user.email, subject: "[Product Update] #{@product.title}")
  end
end
