class Staff::TopController < ApplicationController
  def index
    render action: 'index'#省略しても同じ
  end
end
