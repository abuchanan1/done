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
end
