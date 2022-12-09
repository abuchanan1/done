Rails.application.routes.draw do

  #exporting csv
  get("/export_photos", { :controller => "messages", :action => "export" })


  get("/", { :controller => "messages", :action => "home"})

  #testing sending messages
  get("/send", { :controller => "messages", :action => "send_a_message" })
  post("/run_message", { :controller => "messages", :action => "run_a_message" })

  # Routes for the Message resource:

  # CREATE
  post("/insert_message", { :controller => "messages", :action => "create" })
          
  # READ
  get("/messages", { :controller => "messages", :action => "index" })
  
  get("/messages/:path_id", { :controller => "messages", :action => "show" })
  
  # UPDATE
  
  #post("/modify_message/:path_id", { :controller => "messages", :action => "update" })
  
  # DELETE
  get("/delete_message/:path_id", { :controller => "messages", :action => "destroy" })

  #------------------------------

end
