module Jobs
  class UrlBuilder
    attr_reader :jobs_query

    def initialize(jobs_query)
      @jobs_query = jobs_query
    end

    def build
      query_params = [
        page_param,
        level_params
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
      jobs_query.levels.map do |level|
        "level=#{format_param_value(level)}"
      end
    end

    private def company_params
      jobs_query.companies.map do |company|
        "company=#{format_param_value(company)}"
      end
    end

    private def format_param_value(value)
      value.gsub(' ', '+')
    end
  end
end
