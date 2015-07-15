require 'rails_helper'

describe 'layouts/application' do
  it 'renders flash notices' do
    flash[:notice] = 'It\'s a flash notice!'
    render
    expect(response.body).to include flash[:notice]
  end
end
