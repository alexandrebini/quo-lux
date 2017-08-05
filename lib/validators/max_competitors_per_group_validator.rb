module Validators
  class MaxCompetitorsPerGroupValidator < ActiveModel::Validator
    MAX_COMPETITORS_PER_GROUP = begin
      options = Rails.application.secrets.fetch(:validations, max_competitors_per_group: 8)
      options[:max_competitors_per_group].to_i
    end

    def validate(record)
      competitors_count = record.try(:group).try(:competitors).try(:count)
      return if competitors_count.nil? || competitors_count < MAX_COMPETITORS_PER_GROUP
      record.errors[:base] << 'You have reached the maximum number of competitors on this group'
    end
  end
end
