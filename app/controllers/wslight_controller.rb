class WslightController < ApplicationController
  soap_service namespace: 'urn:WashOutLight', camelize_wsdl: :lower
  # make case
  soap_action "consumption",
              :args   => { :email => :string },
              :return => :float

  def consumption
    @user = User.by_email(params[:email])
    consumption = -1.0
    puts @user
    if @user
      consumption = @user.total_consumption
    end
    render :soap => consumption
  end

  # check case
  soap_action "check",
              :args   => { :email => :string },
              :return => :boolean
  def check
    @user = User.by_email(params[:email])
    validate = true
    if !(@user)
      validate = false
    end
    render :soap => validate
  end

end
