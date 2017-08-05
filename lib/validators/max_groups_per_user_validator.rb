module Validators
  class MaxGroupsPerUserValidator < ActiveModel::Validator
    MAX_GROUPS_PER_USER = begin
      options = Rails.application.secrets.fetch(:validations, max_groups_per_user: 10)
      options[:max_groups_per_user].to_i
    end

    def validate(record)
      groups_count = record.try(:user).try(:groups).try(:count)
      return if groups_count.nil? || groups_count < MAX_GROUPS_PER_USER
      record.errors[:base] << 'You have reached the maximum number of groups'
    end
  end
end
