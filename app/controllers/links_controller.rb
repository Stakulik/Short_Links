class LinksController < ApplicationController

  def create
    @link = Link.new(link_params)
    @link.alias_link = create_alias_link
    
    if @link.save
      $alias_link = @link.alias_link
      redirect_to root_path
    else
      $errors = @link.errors.full_messages
      redirect_to about_path 
    end
  end

  private

  def link_params
    params.require(:link).permit(:original_link, :created_at)
  end

  def this_alias_link_exists?(alias_link)
    /\A(.*)(#{request.host})\/{1}([A-Z0-9]{5})\z/.match alias_link
    return Link.exists?(:alias_link => "#{$2}/#{$3}")
  end

  def array_with_symbols
    symbArr = ('A'..'Z').to_a + (0..9).to_a.map(&:to_s)
    return symbArr
  end

  def create_alias_link
    alias_url = nil
    
    while alias_url == nil
      alias_url = "#{request.host}/"
      5.times { alias_url += array_with_symbols.sample }
      alias_url = nil if this_alias_link_exists?(alias_url)
    end

    return alias_url 
  end

end  

