require "twilio-ruby"

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
