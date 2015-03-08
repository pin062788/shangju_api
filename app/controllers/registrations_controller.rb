class RegistrationsController < Devise::RegistrationsController

  def create
    @consumer = Consumer.create(consumer_params)
    if @consumer.save
      render :json => {:state => {:code => 0}, :data => @consumer }
    else
      render :json => {:state => {:code => 1, :messages => @consumer.errors.full_messages} }
    end

  end
  
  private

  def consumer_params
    params.require(:consumer).permit(:email, :password)
  end
end