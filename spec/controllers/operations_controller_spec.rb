require 'rails_helper'

RSpec.describe OperationsController, type: :controller do
  let(:operation_with_bet) { create(:operation, :with_bet) }
  let(:operation_with_transfer) { create(:operation, :with_transfer) }

  describe 'GET #show_operational' do
    %w[bet transfer].each do |operational|
      context "with #{operational}" do
        before do
          get :show_operational, params: { id: send("operation_with_#{operational}") }
        end

        it 'render show_operational template' do
          expect(response).to render_template :show_operational
        end
      end
    end
  end
end
