class NotificationJob < ApplicationJob
  extend Memoist

  attr_accessor :user_id

  def perform(user_id)
    @user_id = user_id
    return if user.blank?

    user.products.find_each do |user|
      NotificationMailer.product_update(user_id, user.id).deliver_later
    end
  end

  private

  def user
    User.find_by(id: user_id)
  end

  memoize :user
end
