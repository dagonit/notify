require 'rails_helper'

RSpec.describe 'Nofitications', type: :request do
  let(:params) do
    {
      description: 'Accounts need to be reconciled',
      user_id: 42
    }
  end


  describe 'on POST create' do
    before { post "/notifications", params }

    it 'returns new notification' do
      expect(json_response.data['attributes']).to eq({'description' => 'Accounts need to be reconciled', 'user-id' => 42})
    end

    describe 'on GET index' do

      it 'returns all notifications' do
        get "/notifications?user_id=42"

        expect(json_response.data.first['attributes']).to include({'description' => 'Accounts need to be reconciled', 'user-id' => 42})
      end

    end

  end



end
