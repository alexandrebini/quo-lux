namespace :notifications do
  desc 'Delivers daily digest notification'
  task fetch: :environment do
    User.find_each { |user| NotificationJob.perform_later(user.id) }
  end
end
