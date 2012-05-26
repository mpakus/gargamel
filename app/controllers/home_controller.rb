class HomeController < ApplicationController
  def index
    @items_last = Item.all(:limit => 4)
    @categories = Category.all
    @news = News.last(5)
  end
end
