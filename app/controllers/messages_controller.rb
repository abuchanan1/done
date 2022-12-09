class MessagesController < ApplicationController
  require "twilio-ruby"
  require "date"

  
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
    the_message = Message.new
    the_message.message = params.fetch("query_message")
    the_message.phone_number = params.fetch("query_phone_number")

    if the_message.valid?
      the_message.save
      redirect_to("/messages", { :notice => "Message created successfully." })
    else
      redirect_to("/messages", { :alert => the_message.errors.full_messages.to_sentence })
    end



    twilio_sid = ENV.fetch("TWILIO_SID")
    twilio_token = ENV.fetch("TWILIO_TOKEN")
    twilio_sending_number = "+12057493915"
    message = 

    twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

    sms_info = {
      :from => twilio_sending_number,
      :to => the_message.phone_number, # Put your own phone number here if you want to see it in action
      :body => the_message.message
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

    redirect_to("/messages", { :notice  => "Message deleted successfully."} )
  end

  def export
    messages = Message.all
    respond_to do |format|
      format.csv do 
        send_data(messages.to_csv, { :filename => "my_messages.csv"})
      end
    end
  end 
end
