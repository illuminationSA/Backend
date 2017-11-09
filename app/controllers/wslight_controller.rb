class WslightController < ApplicationController
  soap_service namespace: 'urn:WashOutLight', camelize_wsdl: :lower
  # make case
  soap_action "consumption",
              :args   => { :email => :string },
              :return => :float

  def consumption
    puts params[:email]
    user = User.by_email(params[:email])
    consumption = -1.0
    if user
      consumption = 0.0
      user.lights.each do |lt|
        consumption = consumption + lt.consumption
        #puts "lt.consumption = ", lt.consumption
      end
    end

    puts consumption
    render :soap => consumption

  end

  # check case
  soap_action "check",
              :args   => { :email => :string },
              :return => :boolean
  def check
    user = User.by_email(:email)
    validate = true
    if !(user)
      validate = false
    end
    render :soap => validate
  end

end
