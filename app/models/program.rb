class Program < ActiveRecord::Base
  has_many :entries, dependent: :destroy
  has_many :applicants, through: :entries, source: :customer#多対多
  belongs_to :registrant, class_name: 'StaffMember'
end
