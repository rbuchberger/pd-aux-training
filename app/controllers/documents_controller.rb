class DocumentsController < ApplicationController

  def new
    @document = Document.new
    authorize @document
  end

  def create
    @document = Document.new(document_params)
    authorize @document

    if @document.save 
      flash[:success] = "Document created!"
      redirect_to documents_path
    else
      flash.now[:danger] = "Could not create document."
      render :new 
    end
  end

  def show
    @document = get_document

    # This is required because we have our documents set to private on the S3
    # server. It generates a download URL which expires in 10 seconds, allowing
    # us to redirect to it with the show action after authentication and policy
    # verification.

    # More info here: 
    # https://github.com/thoughtbot/paperclip/wiki/Restricting-Access-to-Objects-Stored-on-Amazon-S3
    redirect_to @document.file.expiring_url(10)
  end

  def edit
    @document = get_document
  end

  def update
    @document = get_document

    if @document.update(document_params)
      flash[:success] = "Document updated!"
      redirect_to documents_path
    else
      flash.now[:danger] = "Could not update document"
      render :edit
    end

  end

  def index
    @documents = Document.all
    authorize @documents
  end

  def destroy
    @document = get_document

    if @document.destroy
      flash[:success] = "Document Deleted!"
      redirect_to documents_path
    else 
      flash.now[:danger] = "Could not delete document."
    end
  end

  private 
  
  def get_document
    d = Document.find(params[:id])
    authorize d
    d
  end

  def document_params
    params.require(:document).permit(:name, :description, :file)
  end

end
