# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  before_filter :allow_cors

def allow_cors
  headers["Access-Control-Allow-Origin"] = "*"
  headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE}.join(",")
  headers["Access-Control-Allow-Headers"] =
    %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")

  head(:ok) if request.request_method == "OPTIONS"
  # or, render text: ''
  # if that's more your style
end
end
