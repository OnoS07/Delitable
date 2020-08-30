require 'rails_helper'

RSpec.describe 'Admins::Genres', type: :request do
  before do
    @admin = create(:admin)
    sign_in @admin
  end
  it 'ジャンルの一覧画面が表示できる' do
    get admins_genres_path
    expect(response).to have_http_status(200)
  end

  it 'ジャンルの新規作成リクエストが成功する' do
    post admins_genres_path, params: { genre: FactoryBot.attributes_for(:genre) }
    expect(response).to have_http_status(302)
  end
  it 'ジャンルが1件増える' do
    expect do
      post admins_genres_path, params: { genre: FactoryBot.create(:genre) }
    end.to change(Genre, :count).by(1)
  end
  it '値が正しくない場合、ジャンルが新規作成されない' do
    expect do
      post admins_genres_path, params: { genre: FactoryBot.attributes_for(:genre, name: nil) }
    end.to_not change(Genre, :count)
  end

  context 'ジャンルが必要なリクエスト' do
    before do
      @genre = create(:genre)
    end
    it 'ジャンルの編集画面が表示できる' do
      get edit_admins_genre_path(@genre)
      expect(response).to have_http_status(200)
    end

    it 'ジャンルの更新リクエストが成功する' do
      put admins_genre_path(@genre), params: { genre: FactoryBot.attributes_for(:genre) }
      expect(response).to have_http_status(302)
    end
    it 'ジャンルの更新ができる' do
      expect do
        put admins_genre_path(@genre), params: { genre: FactoryBot.attributes_for(:genre, name: 'update') }
      end.to change { Genre.find(@genre.id).name }.from(@genre.name).to('update')
    end
    it '値が正しくない場合、ジャンルが更新されない' do
      expect do
        put admins_genre_path(@genre), params: { genre: FactoryBot.attributes_for(:genre, name: nil) }
      end.to_not change { Genre.find(@genre.id).name }
    end

    it 'ジャンルの削除リクエストが成功する' do
      delete admins_genre_path(@genre)
      expect(response).to have_http_status(302)
    end
    it 'ジャンルが1件減る' do
      expect do
        delete admins_genre_path(@genre)
      end.to change(Genre, :count).by(-1)
    end
  end
end
