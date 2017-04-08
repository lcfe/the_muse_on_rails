module JobsHelper
  def level_options
    options_for_select([
      'Internship',
      'Entry Level',
      'Mid Level',
      'Senior Level'
    ])
  end
end
