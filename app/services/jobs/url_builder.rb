module Jobs
  class UrlBuilder
    attr_reader :jobs_query

    def initialize(jobs_query)
      @jobs_query = jobs_query
    end

    def build
      query_params = [
        page_param,
        level_params,
        category_params
      ].flatten.join('&')
      query_params = "?#{query_params}" unless query_params.blank?

      "#{base_url}#{query_params}"
    end

    private def base_url
      'https://api-v2.themuse.com/jobs'
    end

    private def page_param
      "page=#{jobs_query.page_number}"
    end

    private def level_params
      convert_array_to_params(jobs_query.levels, 'level')
    end

    private def category_params
      convert_array_to_params(jobs_query.categories, 'category')
    end

    private def company_params
      convert_array_to_params(jobs_query.companies, 'company')
    end

    private def convert_array_to_params(array, param_key)
      array.map do |element|
        "#{param_key}=#{format_param_value(element)}"
      end
    end

    private def format_param_value(value)
      value.gsub(' ', '+')
        .gsub('&', '%26')
    end
  end
end
