require 'spec_helper'

RSpec.describe HealthController, type: :controller do
  it 'answers ok when the database answers' do
    get :show
    expect(response.status).to eq(200)
    expect(response.body).to eq('ok')
  end

  it 'answers 503 when the database does not' do
    allow(ActiveRecord::Base).to receive(:connection).and_raise(ActiveRecord::ConnectionNotEstablished)
    get :show
    expect(response.status).to eq(503)
  end
end
