class Admin::StaffEventsController < Admin::Base
  def index
    if params[:staff_member_id]#ネストされている場合（特定の職員のログ）
      @staff_member = StaffMember.find(params[:staff_member_id])
      @events = @staff_member.events
    else#ネストされていない場合（全員）
      @events = StaffEvent
    end
    @events = @events.order(occurred_at: :desc).includes(:member).page(params[:page])#↓リファクタリング
    # @events = @events.includes(:member)#N+1問題
    # @events = @events.page(params[:page])#kaminari
  end
end
