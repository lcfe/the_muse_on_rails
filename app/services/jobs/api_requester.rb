module Jobs
  class ApiRequester
    def send_request(url)
      uri = URI(url)
      Net::HTTP.get_response(uri)
    end
  end
end
