# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_helpdesk_session',
  :secret      => 'ee38fb673039cef704c4139391732a7a9e931cf7bab4273f255067a36cf74cea9681bfba95dcb45189f2ee40f26673470438b9a343e970c0fabfcd42732be9ba'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
