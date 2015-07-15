class StaticPagesController < ApplicationController
  def main
    @link = Link.new
#    $alias_link = nil
  end

  def about
  end
end
