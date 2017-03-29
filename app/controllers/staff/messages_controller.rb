class Staff::MessagesController < Staff::Base
  before_action :reject_on_xhr, only: [ :count ]
  #GET
  def count
    render text: CustomerMessage.unprocessed.count
  end
end
