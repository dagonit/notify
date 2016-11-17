require 'rails_helper'

RSpec.describe 'Nofitications', type: :request do
  let(:params) do
    {
      description: 'Accounts need to be reconciled',
      user_id: 42
    }
  end


  describe 'on POST create' do

    it 'returns new notification' do
      post "/notifications", params

      expect(json_response.notification).to eq({'description' => 'Accounts need to be reconciled', 'user_id' => '42'})
    end

  end
end
