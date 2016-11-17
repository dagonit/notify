require 'rails_helper'

RSpec.describe 'Notifications', type: :request do
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

    describe 'delete notification' do

      it 'changes active from true to false' do
        notification = Notification.last
        expect(notification.active).to be true

        delete "/notifications/#{notification.id}?user_id=42"
        notification.reload

        expect(notification.active).to be false
      end

      it 'errors on notification that does not exist' do
        notification = Notification.last
        delete "/notifications/#{notification.id + 1}?user_id=42"

        expect(json_response.errors).to include('notification not found')
      end

    end

  end


end
