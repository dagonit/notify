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
      expect(json_response.notification).to eq({'description' => 'Accounts need to be reconciled', 'user_id' => '42'})
    end

  end

  describe 'on GET index' do

    before do
      Notification.create!(
        user_id: 42,
        description: 'Accounts need to be reconciled'
      )
    end

    it 'returns all notifications' do
      get "/notifications?user_id=42"
      expect(json_response.notifications).to include([params])
    end

  end

  describe 'delete notification' do

    before do
      @notification = Notification.create!(
        user_id: 42,
        description: 'Accounts need to be reconciled'
      )
    end

    it 'changes active from true to false' do
      delete "/notifications/#{@notification.id}?user_id=42"
      @notification.reload
      expect(@notification.active).to be_false
    end
  end

end
