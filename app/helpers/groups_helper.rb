module GroupsHelper
  MAX_COMPETITORS = Validators::MaxCompetitorsPerGroupValidator::MAX_COMPETITORS_PER_GROUP

  def setup_group(group)
    missing_competitors = MAX_COMPETITORS - group.competitors.size
    missing_competitors.times { group.competitors.build }
    group
  end
end
