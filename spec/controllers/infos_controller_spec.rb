require 'rails_helper'

RSpec.describe InfosController, type: :controller do
  it "get new view" do
    get :new
    expect(response.status).to eq(200)
  end

  it "get index view" do
    get :index
    expect(response.status).to eq(200)
  end

  it "get edit view" do
    info = create(:info)
    get :edit, params: { id: info.id }
    expect(response.status).to eq(200)
  end

  it "create info" do
    request.env['HTTP_REFERER'] = 'https://commute-info.net/?line_user_id=xxxxxx'
    expect{
      post :create, params: {info: attributes_for(:valid_info)}
    }.to change(Info, :count).by(1)
    expect(response).to redirect_to("http://test.host/?line_user_id=xxxxxx")
  end

  it "flash not empty after created info" do
    request.env['HTTP_REFERER'] = 'https://commute-info.net/?line_user_id=xxxxxx'
    post :create, params: {info: attributes_for(:valid_info)}
    expect(flash[:info]).not_to be_empty
  end

  it "create invalid_info" do
    request.env['HTTP_REFERER'] = 'https://commute-info.net/?line_user_id=xxxxxx'
    expect{
      post :create, params: {info: attributes_for(:invalid_info)}
    }.to change(Info, :count).by(0)
    expect(response).to render_template(:new)
  end

  it "error not empty after created invalid_info" do
    request.env['HTTP_REFERER'] = 'https://commute-info.net/?line_user_id=xxxxxx'
    post :create, params: {info: attributes_for(:invalid_info)}
    expect(flash[:info]).to be nil
  end

  it "update info" do
    info = create(:info)
    request.env['HTTP_REFERER'] = 'https://commute-info.net/edit'
    patch :update, params: { id: info.id, info: attributes_for(:valid_info)}
    info.reload
    expect(info.station1).to eq("さいたま新都心駅")
    expect(info.station2).to eq("川口駅")
    expect(flash[:success]).not_to be_empty
    expect(response).to redirect_to("http://test.host/index?line_user_id=xxxxxx")
  end

  it "update with invalid_info" do
    info = create(:info)
    request.env['HTTP_REFERER'] = 'https://commute-info.net/edit'
    patch :update, params: { id: info.id, info: attributes_for(:invalid_info)}
    expect(response).to render_template(:edit)
    expect(flash[:success]).to be nil
  end

  it "delete info" do
    info = create(:info)
    request.env['HTTP_REFERER'] = "https://commute-info.net/index?line_user_id=#{info.line_user_id}"
    expect{
      delete :destroy, params: { id: info.id }
    }.to change(Info,:count).by(-1)
    expect(flash[:info]).not_to be_empty
  end
end
