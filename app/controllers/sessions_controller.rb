require 'net/ldap' #gem install net-ldap
class SessionsController < ApiController
  skip_before_action :require_login, only: [:create], raise: false

  def connect
    puts "entre a connect"
    ldap = Net::LDAP.new(
      host: '192.168.99.101',
      port: 389,
      auth: {
             method: :simple,
             dn: "cn=admin,dc=arqsoft,dc=unal,dc=edu,dc=co",
             password: "admin"
      }
    )
    return ldap.bind
  end

  def create()
    email = params[:email]
    password = params[:password]
    email = email[/\A\w+/].downcase

    puts "entre a create"
    if connect()
      puts "entre a if connect"
      ldap = Net::LDAP.new(
        host: '192.168.99.101',
        port: 389,
        auth: {
          method: :simple,
          dn: 'cn=' + email + '@unal.edu.co,ou=iLlumination,dc=arqsoft,dc=unal,dc=edu,dc=co',
          password: password
        }
      )
      if ldap.bind
        puts ldap.bind
        if user = User.valid_login?(params[:email], params[:password])
          allow_token_to_be_used_only_once_for(user)
          send_auth_token_for_valid_login_of(user)
          puts 'LDAP validation success'
        else
          puts 'LDAP validation success. User not created in Backend'
        end
      else
        puts 'LDAP validation failed'
        render_unauthorized("Error with your login or password")
      end
    end
  end

  #def create
  #  if user = User.valid_login?(params[:email], params[:password])
  #    allow_token_to_be_used_only_once_for(user)
  #    send_auth_token_for_valid_login_of(user)
  #  else
  #    render_unauthorized("Error with your login or password")
  #  end
  #end

  def destroy
    logout
    head :ok
  end

  private

  def send_auth_token_for_valid_login_of(user)
    render json: { token: user.token, id: user.id }
  end

  def allow_token_to_be_used_only_once_for(user)
    user.regenerate_token
  end

  def logout
    current_user.invalidate_token
  end
end
