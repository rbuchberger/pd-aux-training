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
      redirect_to document_path(@document)
    else
      flash.now[:danger] = "Could not create document."
      render :new 
    end
  end

  def show
    @document = get_document
  end

  def download
    # This is required because we have our documents set to private on the S3
    # server. It generates a download URL which expires in 10 seconds, allowing
    # us to use link_to helpers to make download buttons. 

    # More info here: 
    # https://github.com/thoughtbot/paperclip/wiki/Restricting-Access-to-Objects-Stored-on-Amazon-S3

    @document = get_document
    authorize @document

    redirect_to @document.file.expiring_url(10)
  end

  def edit
    @document = get_document
  end

  def update
    @document = get_document

    if @document.save
      flash[:success] = "Document updated!"
      redirect_to document_path(@document)
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
  end

  private 
  
  def get_document
    d = Document.find(params[:id])
    authorize d
    d
  end

  def document_params
    params.require(:document).require(:name, :description, :file)
  end

end
