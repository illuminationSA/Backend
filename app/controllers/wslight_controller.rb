class WslightController < ApplicationController
  soap_service namespace: 'urn:WashOutLight', camelize_wsdl: :lower
  # make case
  soap_action "consumption",
              :args   => { :email => :string },
              :return => :float

  def consumption
    user = User.by_email(:email)
    consumption = 0.0
    user.lights.each do |lt|
      consumption = consumption + lt.consumption
    end

    render :soap => consumption
  end

  # check case
  soap_action "check",
              :args   => { :email => :string },
              :return => :boolean
  def check
    user = User.by_email(:email)
    validate = true
    if !( User.exists?(user.id) )
      validate = false
    end
    render :soap => validate
  end

end
