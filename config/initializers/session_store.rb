# Be sure to restart your server when you modify this file.

Yamon::Application.config.session_store :cookie_store, :key => '_yamon3_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Yamon::Application.config.session_store :active_record_store
