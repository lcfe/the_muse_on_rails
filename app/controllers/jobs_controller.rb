class JobsController < ApplicationController
  def index
    @jobs_query = JobsQuery.new(params.fetch(:jobs_query, {}))
    query_executor = Jobs::QueryExecutor.new(@jobs_query)
    @query_response = query_executor.execute
    status = @query_response.status
  end
end
