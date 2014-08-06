
def set_authentication_stub_request(hostname, client_id, client_key, token)
  body = {
    :access_token => "e58af350-6c40-453f-8883-35f12d2e8742:qe",
    :token_type => "bearer",
    :expires_in => 86183,
    :scope => "ser@user.com"
  }

  # Endpoint expects these headers
  headers = {
    'Accept'=>'*/*',
    'User-Agent'=>'Ruby',
  }
  headers.delete('User-Agent') if RUBY_VERSION < '1.9'

  stub_request(:get, "https://#{hostname}/identity/oauth/token?client_id=#{client_id}&client_secret=#{client_key}&grant_type=client_credentials").
    with(:headers => headers).
    to_return(:status => 200,
              :body => body.to_json,
              :headers => {})
end

def set_get_leads_stub_request(type, email, hostname, token)
  url = "https://#{hostname}/rest/v1/leads.json?access_token=#{token}&filterType=#{type}&filterValues=#{email}"

  # expected body
  body = {
    :requestId => 1,
    :success => true,
    :result => [
                {
                  :id => 1,
                  :email => email
                }
               ]
  }

  # Endpoint expects these headers
  headers = {
    'Accept'=>'*/*',
    'User-Agent'=>'Ruby',
  }
  headers.delete('User-Agent') if RUBY_VERSION < '1.9'

  stub_request(:get, url).with(:headers => headers).
    to_return(:status => 200, :body => body.to_json, :headers => {})
end

def set_update_lead_stub_request(type, value, fields, hostname, token)

  # Endpoint expect this body
  req_body = {
    :action => "updateOnly",
    :lookupField => type.to_s,
    :input => [ { type => value  }.merge(fields) ]
  }.to_json

  # Endpoint expects these headers
  headers = {
    "Authorization" => "Bearer #{token}",
    'Content-Type'=>'application/json',
    'Accept'=>'*/*',
    'User-Agent'=>'Ruby',
  }
  headers.delete('User-Agent') if RUBY_VERSION < '1.9'

  # response expected body
  resp_body = {
    :requestId => 1,
    :success => true,
    :result => [
                {
                  type.to_s => value
                }
               ]}.to_json

  stub_request(:post, "https://#{hostname}/rest/v1/leads.json?").
    with(:headers => headers,:body => req_body).
    to_return(:status => 200, :body => resp_body )
end
