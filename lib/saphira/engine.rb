require 'saphira/middleware/flash_session_cookie'
module Saphira
  class Engine < Rails::Engine
    isolate_namespace Saphira
    
    initializer "saphira.add_middleware" do |app|
      app.middleware.insert_before(
        ActionDispatch::Session::CookieStore,
        Saphira::Middleware::FlashSessionCookie,
        Rails.application.config.session_options[:key]
      )
    end
  end
end
