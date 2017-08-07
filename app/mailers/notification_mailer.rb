class NotificationMailer < ApplicationMailer
  DIFF_SOURCE_DATE = Rails.application.secrets.fetch(
    :daily_diggest_source_date,
    'yesterday at 00:00:00'
  ).freeze

  def daily_digest(user_id)
    @user = User.find_by(id: user_id)
    @products = changed_products(@user)
    return if @user.blank? || @products.blank?

    mail(to: @user.email, subject: "[Quo-Lux] Daily Digest #{Date.today}")
  end

  private

  def changed_products(user)
    # diff_source_date = Chronic.parse(DIFF_SOURCE_DATE)
    diff_source_date = 1.hour.ago
    user.products.map { |product| product.diff(diff_source_date) }.select(&:present?)
  end
end
