class JobsQuery
  attr_reader :params, :page_number, :companies, :levels, :categories

  def initialize(params = {})
    @params = params
    @page_number = extract_page_number_from_params
    @companies = extract_array_from_params('companies')
    @levels = extract_array_from_params('levels')
    @categories = extract_array_from_params('categories')
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

  private def extract_page_number_from_params
    page_number = params['page_number']
    page_number = default_page_number if page_number.blank?

    page_number
  end

  private def default_page_number
    1
  end

  private def extract_array_from_params(key)
    params.fetch(key, []).reject(&:blank?)
  end
end
