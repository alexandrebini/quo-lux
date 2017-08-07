namespace :notifications do
  desc 'Delivers daily digest notification'
  task fetch: :environment do
    User.find_each { |user| NotificationMailer.daily_digest(user.id).deliver_later }
  end
end
