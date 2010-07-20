Factory.define :client_application, :class => OAuth2::Models::ActiveRecord::ClientApplication do |ca|
  ca.external_id 'gnomeslab'
  ca.secret      'secret'
end