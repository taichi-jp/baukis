class Admin::TopController < ApplicationController
  def index
    render action: 'index'#省略しても同じ
  end
end
