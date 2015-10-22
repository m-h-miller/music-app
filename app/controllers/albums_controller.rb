class AlbumsController < ApplicationController

  def new
    @album = Album.new(band_id: params[:band_id])
    @all_bands = Band.all
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to band_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = album.find(params[:id])
  end

  private
    def album_params
      params.require(:album).permit(:title, :band_id, :album_type)
    end

end
