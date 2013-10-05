class AttachmentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    a = nil
    params[:file].each do |file|
      a = Attachment.new
      a.asset = file
      a.save
    end
    
    render json: {id: a.id.to_s, t_path: a.asset.thumb.url, l_path: a.asset.large.url,
                  m_path: a.asset.medium.url, s_path: a.asset.small.url }
  end
  
  def destroy
    @attachment = Attachment.find params[:id]
    @attachment.destroy
    render json: {}
  end

end
