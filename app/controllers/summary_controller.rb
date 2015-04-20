class SummaryController < ApplicationController
  def index
    @summary = Summary.all
    @post = Post.all
  end

  def new
    #@post    = Post.find(params[:id])
    @summary = Summary.new
  end

  def create
    #@post = Post.find(params[:post_id])
    @summary = Summary.new(params.require(:summary).permit(:description))
    @summary.post = @post
    #authorize @summary

    if @summary.save
      flash[:notice] = "Summary was saved"
      redirect_to @summary
    else
      flash[:error] = "There was an error saving the summary. Please try again."
      render :new
    end
  end

  def edit
    #@post   =    Post.find(params[:id])
    @summary = Summary.find(params[:id])
    #authorize @summary
  end

  def update
    #@post = Post.find(params[:post_id])
    
    @summary = Summary.find(params[:id])
   # authorize @post

    if @summary.update_attributes(params.require(:summary).permit(:description))
      flash[:notice] = "Summary was updated"
      redirect_to @summary
    else
      flash[:error] = "There was an error saving the summary. Please try again."
      render :edit
    end
  end

  def show
    @summary = Summary.find(params[:id])
  end

end
