class BulletinsController < ApplicationController
  def new
    @bulletin = current_user.bulletins.build
    authorize @bulletin
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)
    authorize @bulletin
    if @bulletin.save
      flash[:success] = "Bulletin created!"
      redirect_to root_path
    else
      flash[:alert] = "Could not save bulletin"
      redirect_to new_bulletin_path
    end
  end

  def edit
    @bulletin = get_bulletin
    authorize @bulletin
  end

  def update
    @bulletin = get_bulletin
    authorize @bulletin
    if @bulletin.update(bulletin_params)
      flash[:success] = 'Bulletin updated!'
      redirect_to root_path
    else
      flash[:alert] = 'Could not update bulletin'
      render edit_bulletin_path(@bulletin)
    end
  end

  def destroy
    @bulletin = get_bulletin
    authorize @bulletin
    if @bulletin.destroy
      flash[:success] = 'Bulletin deleted!'
      redirect_to root_path
    else
      flash[:alert] = 'Could not delete bulletin'
      redirect_to root_path
    end
  end

  def show
    @bulletin = get_bulletin
    authorize @bulletin
  end

  private

  def get_bulletin
    Bulletin.find(params[:id])
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :body)
  end

end
