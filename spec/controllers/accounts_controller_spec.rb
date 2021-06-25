require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let(:account) { create(:account) }

  describe 'GET #index' do
    let(:accounts) { create_list(:account, 2) }

    before do
      get :index
    end

    it 'get all accounts' do
      expect(assigns(:accounts)).to match_array(accounts)
    end

    it 'render index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: account }
    end

    it 'render show template' do
      expect(response).to render_template :show
    end
  end
end
