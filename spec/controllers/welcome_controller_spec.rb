require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe 'GET index' do
    it 'display index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'POST register' do
    it 'display a success flash message' do
      User.where(email: 'test@example.com').delete_all
      expect do
        post :register, email: 'test@example.com'
      end.to change { User.count }.by(1)

      expect(flash[:success]).to eq I18n.t('email.add.success')
      expect(response).to redirect_to root_path
    end

    it 'display an error flash message' do
      post :register, email: 'It\'s not an email'
      expect(flash[:error]).to eq I18n.t('email.add.error')
      expect(response).to redirect_to root_path
    end

    it 'return a JSON with an success message' do
      User.where(email: 'test@example.com').delete_all
      post :register, email: 'test@example.com', format: 'json'
      expect(JSON.parse(response.body)['success'])
        .to eq I18n.t('email.add.success')
    end

    it 'return a JSON with an error message' do
      post :register, email: 'It\'s not an email', format: 'json'
      expect(JSON.parse(response.body)['error'])
        .to eq I18n.t('email.add.error')
    end
  end
end
