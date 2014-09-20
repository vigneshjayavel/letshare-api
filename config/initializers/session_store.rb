# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_letshare_session',
  :secret      => '4e2d6ace065ed61ab4bca58a7156e2d5d251a60ab6a14dea163ec6aa2b7f9013a34eb264e71275be414d7a7b3313cde9f82104a0f12db4c3a767d968a96a600a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
