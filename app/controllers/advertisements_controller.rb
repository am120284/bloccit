class AdvertisementsController < ApplicationController
  def index
  	@advertisement = Advertisement.all
  end

  def show
  	@advertisements = Advertisement.find(params[:id])
  end
end
