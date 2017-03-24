class Customer::EntryAcceptor
  def initialize(customer)
    @customer = customer
  end

  def accept(program)
    raise if Time.current < program.application_start_time
    return :closed if Time.current >= program.application_end_time
    ActiveRecord::Base.transaction do
      program.lock!#排他的ロックを取得（transaction内でやる）
      if program.entries.where(customer_id: @customer.id).exists?
        return :accepted#二重にcreateしないように
      elsif max = program.max_number_of_participants
        if program.entries.where(canceled: false).count < max
          program.entries.create!(customer: @customer)
          return :accepted
        else
          return :full
        end
      else#（max_number_of_participantsが設定されていない場合）
        program.entries.create!(customer: @customer)
        return :accepted
      end
    end
  end
end
