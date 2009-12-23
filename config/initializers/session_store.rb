# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_projexion_session',
  :secret      => '177af34e99017c64f06954e25a0a9e22cfa30abc5b2f78755937b6907a5eff207456bdaf7dc581b4ea33c25d03ee6d54d1c51d26d374b88c4b18657cc79e1990'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
