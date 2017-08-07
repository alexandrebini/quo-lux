class NotificationMailer < ApplicationMailer
  def daily_digest(user_id)
    @user = User.find_by(id: user_id)
    @changeset = @product.versions.last.changeset

    return if @product.blank? || @user.blank? || !changed?(@product)

    mail(to: @user.email, subject: "[Product Update] #{@product.title}")
  end

  private

  def changed?(product)
    product.versions.last.changeset.any? do |key, _value|
      Product::NOTIFICABLE_ATTRIBUTES.include?(key.to_sym)
    end
  end
end
