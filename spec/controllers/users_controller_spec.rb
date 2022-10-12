require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #profile' do
    before do
      login(user)
      get :profile
    end

    it 'render show template' do
      expect(response).to render_template :profile
    end
  end
end
