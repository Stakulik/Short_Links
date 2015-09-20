class LinksController < ApplicationController

  def create
    @link = Link.new(link_params)

    if @link.save
      flash[:success] = "#{request.host}/#{@link.alias_link}"
      redirect_to root_path
    else
      flash.now[:error] = "Указана некорректная ссылка."
      render 'static_pages/main'
    end
  end

  def router
    if @link = Link.find_by_alias_link(params[:alias_link])
      @link.save if @link.update_destroy_date
      redirect_to @link.original_link
    elsif params[:alias_link].size == 5
      flash[:error] = "Данная ссылка не существует или была удалена."
      redirect_to root_path   
    else
      redirect_to root_path
    end
  end

  private

  def link_params
    params.require(:link).permit(:original_link, :created_at)
  end

end