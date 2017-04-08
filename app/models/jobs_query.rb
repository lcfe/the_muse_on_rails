class JobsQuery
  attr_reader :page_number, :companies, :levels

  def initialize(params = {})
    @page_number = params.fetch('page_number', default_page_number)
    @companies = params.fetch('companies', []).reject(&:blank?)
    @levels = params.fetch('levels', []).reject(&:blank?)
  end

  # This method is needed to conform with the API that Rails' form_for helper
  # method expects.
  def model_name
    OpenStruct.new(param_key: 'jobs_query')
  end

  # This method is needed to conform with the API that Rails' form_for helper
  # method expects.
  def to_key
  end

  private def default_page_number
    1
  end
end
