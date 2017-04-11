module Jobs
  class QueryExecutor
    attr_reader :jobs_query
    def initialize(jobs_query)
      @jobs_query = jobs_query
    end

    def execute
      response = api_requester.send_request(url)
      data = JSON.parse(response.body)
      if response.code.to_s == '200'
        OpenStruct.new(data.merge(status: response.code))
      else
        OpenStruct.new(data.merge(
          page: 0,
          page_count: 0,
          total: 0,
          results: [],
          status: response.code
        ))
      end
    end

    private def url
      @url ||= url_builder.build
    end

    private def url_builder
      @url_builder ||= Jobs::UrlBuilder.new(jobs_query)
    end

    private def api_requester
      @api_requester ||= Jobs::ApiRequester.new
    end
  end
end
