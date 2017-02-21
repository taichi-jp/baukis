class Admin::TopController < Admin::Base
  def index
    render action: 'index'#省略しても同じ
  end
end
