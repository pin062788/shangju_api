class SessionsController < Devise::SessionsController
  # https://github.com/plataformatec/devise/blob/master/app/controllers/devise/sessions_controller.rb

  # POST /resource/sign_in
  # Resets the authentication token each time! Won't allow you to login on two devices
  # at the same time (so does logout).
  def create
   self.resource = warden.authenticate!(auth_options)
   sign_in(resource_name, resource)
 
   current_consumer.update authentication_token: nil
 
   respond_to do |format|
     format.json {
       render :json => {
         :consumer => current_consumer,
         :status => :ok,
         :authentication_token => current_consumer.authentication_token
       }
     }
   end
  end

  # DELETE /resource/sign_out
  def destroy
 
   respond_to do |format|
     format.json {
       if current_consumer
         current_consumer.update authentication_token: nil
         signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
         render :json => {}.to_json, :status => :ok
       else
         render :json => {}.to_json, :status => :unprocessable_entity
       end
     }
   end
  end
end