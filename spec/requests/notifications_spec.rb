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

    it 'returns an error with invalid parameters - user_id' do
      post "/notifications", params: { description: 'Accounts need to be reconciled' }

      expect(json_response.errors.user_id).to include("can't be blank")
    end

    it 'returns an error with invalid parameters - description' do
      post "/notifications", params: { user_id: 44 }

      expect(json_response.errors.description).to include("can't be blank")
    end

    it 'description has a cap of 200 characters' do
      test_string = "x " * 101
      post "/notifications", params: { user_id: 44, description: test_string}

      expect(json_response.errors.description).to include('is too long (maximum is 200 characters)')
    end

    describe 'on GET index' do

      it 'returns all notifications' do
        get "/notifications?user_id=42"

        expect(json_response.data.first['attributes']).to include({'description' => 'Accounts need to be reconciled', 'user-id' => 42})
      end

    end

    describe 'delete notification' do

      it 'a notification is active by default' do
        expect(Notification.last.active).to be true
      end

      it 'changes active from true to false' do
        delete "/notifications/#{Notification.last.id}?user_id=42"

        expect(Notification.last.active).to be false
      end

      it 'errors on notification that does not exist' do
        notification = Notification.last
        delete "/notifications/#{notification.id + 1}?user_id=42"

        expect(json_response.errors).to include('notification not found')
      end

    end

  end


end
