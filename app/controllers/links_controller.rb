class LinksController < ApplicationController

  def create
    @link = Link.new(link_params)

    if is_it_domain?(@link.original_link)
      @link.original_link = add_http_protocol(@link.original_link)    
      @link.alias_link = create_alias_link
    end 

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

  def is_it_domain?(original_link)
    result = /\A(.*)([a-z0-9а-я]+)\.([a-zа-я]{2,})(\/.*)?\z/i =~ original_link
    if result != nil
      return true
    else
      return false
    end
  end

  def add_http_protocol(original_link)
    protocols = %w[http https ftp]

    /\A((https?|ftp)\:\/\/)?(.+)\.([а-яa-z]{2,})\/?(.*)\z/i.match original_link
    original_link.insert(0, 'http://') unless protocols.index($2)

    return original_link
  end


  def array_with_symbols
    symbArr = ('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a.map(&:to_s)
    return symbArr
  end

  def this_alias_link_exists?(alias_link)
    /\A([a-zA-Z0-9]{5})\z/.match alias_link
    return Link.exists?(:alias_link => "#{$1}")
  end

  def create_alias_link
    alias_url = nil
    
    while alias_url == nil
      alias_url = ""
      5.times { alias_url += array_with_symbols.sample }
      alias_url = nil if this_alias_link_exists?(alias_url)
    end

    return alias_url 
  end

end  

