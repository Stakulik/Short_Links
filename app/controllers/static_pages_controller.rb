class StaticPagesController < ApplicationController
  def main
    @link = Link.new
  end

end
