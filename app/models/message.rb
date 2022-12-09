# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  automate     :boolean
#  due_date     :date
#  message      :string
#  phone_number :string
#  task_name    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Message < ApplicationRecord

  def self.to_csv
    messages = self.all
    headers = ["id", "phone_number", "message", "created_at"]
    csv = CSV.generate(headers: true) do |csv|
      csv << headers
      messages.each do |message|
        row = []
        row.push(message.id)
        row.push(message.phone_number)
        row.push(message.message)
        row.push(message.created_at)
        csv << row
      end
    end
    return csv
  end
end 
