class Customer::MessagesController < Customer::Base
  def new
    @message = CustomerMessage.new
  end

  def index
    @messages = current_customer.inbound_messages
      .where(discarded: false).page(params[:page])
  end

  def show
    @message = current_customer.inbound_messages.find(params[:id])
  end

  #GET
  def discarded
    @messages = Message.where(discarded: true)#.page(params[:page])
    narrow_down
    @messages = @messages.page(params[:page])
    render action: 'index'
  end

  #POST
  def confirm
    @message = CustomerMessage.new(customer_message_params)
    if @message.valid?
      render action: 'confirm'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: ' new'
    end
  end

  def create
    @message = CustomerMessage.new(customer_message_params)
    if params[:commit]
      @message.customer = current_customer
      if @message.save
        flash.notice = '問い合わせを送信しました。'
        redirect_to :customer_root
      else
        flash.now.alert = '入力に誤りがあります。'
        render action: 'new'
      end
    else
      render action: 'new'
    end
  end

  def destroy
    message = StaffMessage.find(params[:id])
    message.update_column(:discarded, true)
    flash.notice = '問い合わせを削除しました。'
    redirect_to :back
  end

  private
  def customer_message_params
    params.require(:customer_message).permit(:subject, :body)
  end

  def narrow_down
    if params[:tag_id]
      @messages = @messages.joins(:message_tag_links)
        .where('message_tag_links.tag_id' => params[:tag_id])
    end
  end
end
