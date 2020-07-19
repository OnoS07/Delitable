class Admins::GenresController < ApplicationController
  before_action :authenticate_admin!
  def index
    @genres = Genre.all
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admins_genres_path
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params_update)
    redirect_to admins_genres_path
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admins_genres_path
  end

  def genre_params
    params.permit(:name, :introduction)
  end

  def genre_params_update
    params.require(:genre).permit(:name, :introduction)
  end
end
