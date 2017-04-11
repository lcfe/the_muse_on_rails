require 'rails_helper'

describe Jobs::QueryExecutor do
  subject do
    described_class.new(jobs_query)
  end

  let(:jobs_query) do
    JobsQuery.new
  end
  let(:url_builder) do
    instance_double(
      'Jobs::UrlBuilder',
      build: 'some.url.to.somewhere'
    )
  end
  let(:api_requester) do
    instance_double(
      'Jobs::ApiRequester',
      send_request: response
    )
  end
  let(:response) do
    OpenStruct.new(
      code: code,
      body: body
    )
  end
  let(:code) do
    '200'
  end
  let(:body) do
    { fake: 'data' }.to_json
  end
  let(:returned_object) do
    subject.execute
  end

  before do
    allow(Jobs::UrlBuilder).to receive(:new) { url_builder }
    allow(Jobs::ApiRequester).to receive(:new) { api_requester }
  end

  describe '#execute' do
    context 'when the request is successful' do
      let(:code) do
        '200'
      end
      let(:page) do
        10
      end
      let(:page_count) do
        21
      end
      let(:total) do
        402
      end
      let(:results) do
        {
          'result_1' => { 'details' => 'go here' },
          'result_2' => { 'details' => 'go here' },
          'result_3' => { 'details' => 'go here' }
        }
      end
      let(:body) do
        {
          page: page,
          page_count: page_count,
          total: total,
          results: results,
          code: code
        }.to_json
      end

      describe 'returned object' do
        it 'responds to #page with the page value in the JSON response' do
          expect(returned_object.page).to eql page
        end
        it 'responds to #page_count with the page_count value in the JSON response' do
          expect(returned_object.page_count).to eql page_count
        end
        it 'responds to #total with the total value in the JSON response' do
          expect(returned_object.total).to eql total
        end
        it 'responds to #results with the results value in the JSON response' do
          expect(returned_object.results).to eql results
        end
        it 'responds to #status with the response code' do
          expect(returned_object.status).to eql code
        end
      end
    end

    context 'when the request is unsuccessful' do
      let(:code) do
        '404'
      end
      let(:error) do
        'Something went wrong'
      end
      let(:body) do
        {
          code: code,
          error: error
        }.to_json
      end

      describe 'returned object' do
        it 'responds to #page with 0' do
          expect(returned_object.page).to eql 0
        end
        it 'responds to #page_count with 0' do
          expect(returned_object.page_count).to eql 0
        end
        it 'responds to #total with 0' do
          expect(returned_object.total).to eql 0
        end
        it 'responds to #results with an empty array' do
          expect(returned_object.results).to eql []
        end
        it 'responds to #status with the response code' do
          expect(returned_object.status).to eql code
        end
        it 'responds to #error with the error from the JSON response' do
          expect(returned_object.error).to eql error
        end
      end
    end
  end
end
