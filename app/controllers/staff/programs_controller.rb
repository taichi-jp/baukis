class Staff::ProgramsController < Staff::Base
  def index
    # @programs = Program.order(application_start_time: :desc)
    #   .includes(:registrant).page(params[:page])
    # モデルでlistingスコープを定義
    @programs = Program.listing.page(params[:page])
  end

  def show
    @program = Program.listing.find(params[:id])
  end
end
