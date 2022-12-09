class MessagesController < ApplicationController
  require "twilio-ruby"

  
  def home
    render({ :template => "messages/home.html.erb"})
  end 
  
  def index
    matching_messages = Message.all

    @list_of_messages = matching_messages.order({ :created_at => :desc })

    render({ :template => "messages/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_messages = Message.where({ :id => the_id })

    @the_message = matching_messages.at(0)

    render({ :template => "messages/show.html.erb" })
  end

  def send_a_message
    render({ :template => "messages/send.html.erb"})
  end


  def run_a_message


    twilio_sid = "ACb7b876131bda71bcd2eb2367d1a48493"
    twilio_token = "2ccd360cec20d8a0c77b74884bf88fd3"
    twilio_sending_number = "+12057493915"
    message = 

    twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

    sms_info = {
      :from => twilio_sending_number,
      :to => "+13212020962", # Put your own phone number here if you want to see it in action
      :body => "It's going to rain today — take an umbrella!"
    }

    twilio_client.api.account.messages.create(sms_info) 
  end

  def create
    the_message = Message.new
    the_message.automate = params.fetch("query_automate", false)
    the_message.message = params.fetch("query_message")
    the_message.due_date = params.fetch("query_due_date")
    the_message.task_name = params.fetch("query_task_name")
    the_message.phone_number = params.fetch("query_phone_number")

    if the_message.valid?
      the_message.save
      redirect_to("/messages", { :notice => "Message created successfully." })
    else
      redirect_to("/messages", { :alert => the_message.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_message = Message.where({ :id => the_id }).at(0)

    the_message.automate = params.fetch("query_automate", false)
    the_message.message = params.fetch("query_message")
    the_message.due_date = params.fetch("query_due_date")
    the_message.task_name = params.fetch("query_task_name")
    the_message.phone_number = params.fetch("query_phone_number")

    if the_message.valid?
      the_message.save
      redirect_to("/messages/#{the_message.id}", { :notice => "Message updated successfully."} )
    else
      redirect_to("/messages/#{the_message.id}", { :alert => the_message.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_message = Message.where({ :id => the_id }).at(0)

    the_message.destroy

    redirect_to("/messages", { :notice => "Message deleted successfully."} )
  end
end
