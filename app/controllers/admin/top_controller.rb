class Admin::TopController < Admin::Base
  def index
    if current_administrator
      render action: 'dashboard'
    else
      render action: 'index'#省略しても同じ
    end
  end
end
