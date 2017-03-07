class Staff::CustomerForm
  include ActiveModel::Model
                            #フォームのオプショナル用
  attr_accessor :customer, :inputs_home_address, :inputs_work_address
  delegate :persisted?, :save, to: :customer

  def initialize(customer = nil)
    @customer = customer
    @customer ||= Customer.new(gender: 'male')
    (2 - @customer.personal_phones.size).times do
      @customer.personal_phones.build
    end
    self.inputs_home_address = @customer.home_address.present?#
    self.inputs_work_address = @customer.work_address.present?#持っていればonに
    @customer.build_home_address unless @customer.home_address
    @customer.build_work_address unless @customer.work_address
  end

  def assign_attributes(params = {})
    @params = params
    self.inputs_home_address = params[:inputs_home_address] == '1'#
    self.inputs_work_address = params[:inputs_work_address] == '1'#(check_boxがonなら1と等しいのでtrueを返す)

    customer.assign_attributes(customer_params)
    if inputs_home_address
      customer.home_address.assign_attributes(home_address_params)
    else
      customer.home_address.mark_for_destruction
    end
    if inputs_work_address
      customer.work_address.assign_attributes(work_address_params)
    else
      customer.work_address.mark_for_destruction
    end
  end

  #has_oneのautosaveオプションにより不要
  # def valid?###関連オブジェクト(2つのaddress)についても同時に検証するようにする
  #   # customer.valid? && customer.home_address.valid? &&
  #   #   customer.work_address.valid?#これでは&&の性質上最初のfalseしか検証されない
  #
  #   # [ customer, customer.home_address, customer.work_address ]
  #   #   .map(&:valid?).all?
  # end

  #delegateにより不要
  # def save
  #   # if valid?###↑がなければ2つのaddressが検証されずエラーがでる
  #   #   ActiveRecord::Base.transaction do#トランザクション
  #   #     customer.save!
  #   #     customer.home_address.save!
  #   #     customer.work_address.save!
  #   #   end
  #   # end
  #
  #   customer.save#autosaveオプションによりシンプルに
  # end

  private
  def customer_params
    @params.require(:customer).permit(
      :email, :password,
      :family_name, :given_name, :family_name_kana, :given_name_kana,
      :birthday, :gender
    )
  end

  def home_address_params
    @params.require(:home_address).permit(
      :postal_code, :prefecture, :city, :address1, :address2
    )
  end

  def work_address_params
    @params.require(:work_address).permit(
      :postal_code, :prefecture, :city, :address1, :address2,
      :company_name, :division_name
    )
  end
end
