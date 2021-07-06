require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:users) { create_list(:user, 2) }

    before do
      get :index
    end

    it 'get all accounts' do
      expect(assigns(:users)).to match_array(users)
    end

    it 'render index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: user }
    end

    it 'render show template' do
      expect(response).to render_template :show
    end
  end
end
