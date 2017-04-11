require 'rails_helper'

describe Jobs::UrlBuilder do
  let(:jobs_query) do
    JobsQuery.new(params)
  end
  let(:params) do
    {}
  end

  subject do
    described_class.new(jobs_query)
  end

  describe '#build' do
    context 'when the query includes a page number' do
      let(:params) do
        HashWithIndifferentAccess.new(
          page_number: 5
        )
      end
      it 'returns the correct url' do
        expected_url = 'https://api-v2.themuse.com/jobs?page=4'
        expect(subject.build).to eql expected_url
      end
    end

    context 'when the query includes level params' do
      let(:params) do
        HashWithIndifferentAccess.new(
          levels: ['Level Uno', 'Level Dos', 'LevelWithNoSpaces']
        )
      end
      it 'returns the correct url' do
        expected_url = 'https://api-v2.themuse.com/jobs?page=0&level=Level+Uno&level=Level+Dos&level=LevelWithNoSpaces'
        expect(subject.build).to eql expected_url
      end
    end
  end
end
