class BulletinsController < ApplicationController
  def new
    @bulletin = current_user.bulletins.build
  end

  def index
    @bulletins = Bulletin.all
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)
    if @bulletin.save
      flash[:success] = "Bulletin created!"
    else
      flash[:alert] = "Could not save bulletin"
    end
  end

  def edit
    @bulletin = get_bulletin
  end

  def update
    @bulletin = get_bulletin
    if @bulletin.update(bulletin_params)
      flash[:success] = 'Bulletin updated!'
    else
      flash[:alert] = 'Could not update bulletin'
    end
  end

  def destroy
    @bulletin = get_bulletin
    if @bulletin.destroy
      flash[:success] = 'Bulletin deleted!'
    else
      flash[:alert] = 'Could not delete bulletin'
    end
  end

  def show
    @bulletin = get_bulletin
  end

  private

  def get_bulletin
    Bulletin.find(params[:id])
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :body)
  end

end
