class Staff::TopController < Staff::Base
  def index
    render action: 'index'#省略しても同じ
  end
end
