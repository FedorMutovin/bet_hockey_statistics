require 'rails_helper'

shared_examples 'operated' do
  describe 'GET #show' do
    before do
      get :show, params: { id: operational.id }
    end

    it 'render show template' do
      expect(response).to render_template :show
    end
  end
end
