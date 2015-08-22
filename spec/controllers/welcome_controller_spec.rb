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

  describe 'GET unsubscribe' do
    email = 'test@example.com'

    it 'unsubscribe user successfully' do
      User.create(email: email)
      get :unsubscribe, email: email
      expect(User.where(email: email).count).to be == 0
      expect(flash[:success]).to eq I18n.t('email.remove.success')
    end

    it 'returns an error when user does not exists in our database' do
      User.destroy_all(email: email)
      get :unsubscribe, email: email
      expect(flash[:error]).to eq I18n.t('email.remove.error')
    end
  end

  describe 'POST contact' do
    it 'displays a success message if flood control wasn\'t triggered' do
      begin
        Rails.cache.clear # Clearing the cache to empty previous sessions
      rescue
        Rails.logger.debug('Cache uninitialized')
      end

      expect do
        post :contact_send, contact: {
          name: 'Example',
          email: 'user@example.com',
          message: 'lipsum' }
      end.to change { ActionMailer::Base.deliveries.count }.by 1
      expect(response).to redirect_to root_path
      expect(flash[:success]).to eq I18n.t('welcome.contact_send.success')
    end

    it 'triggers flood control' do
      2.times do
        post :contact_send, contact: {
          name: 'Example',
          email: 'user@example.com',
          message: 'lipsum' }
        expect(response).to render_template :contact
      end
      expect(flash[:error]).to eq I18n.t('welcome.contact_send.flood')
    end

    it 'display an error message when form is invalid' do
      # Clearing the cache to empty previous sessions
      begin
        Rails.cache.clear
      rescue
        Rails.logger.debug('Cache uninitialized')
      end

      post :contact_send, contact: {
        name: '',
        email: 'test',
        message: '' }
      expect(flash[:error]).to eq I18n.t('welcome.contact_send.invalid')
      expect(response).to render_template :contact
    end
  end
end
