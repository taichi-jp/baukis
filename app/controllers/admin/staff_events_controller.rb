class Admin::StaffEventsController < Admin::Base
  def index
    if params[:staff_member_id]#ネストされている場合（特定の職員のログ）
      @staff_member = StaffMember.find(params[:staff_member_id])
      @events = @staff_member.events.order(occurred_at: :desc)
    else#ネストされていない場合（全員）
      @events = StaffEvent.order(occurred_at: :desc)
    end
    @events = @events.page(params[:page])#kaminari
  end
end
