# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_projexion_session',
  :secret      => '58e218c52c5fd34c2e488524a3b4a54e9888257aa1e4bf39d16f1086bc91006851cdde9649e87fac7ee91e9fef08ab269465ebb1c056f8b10ea9a3c4715a4a2e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
