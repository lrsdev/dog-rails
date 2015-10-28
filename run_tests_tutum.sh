# Tutum executes this file during the autobuild process
# Briefly pause to allow database init to finish (find a better way to do this)
sleep 10s
rake db:migrate RAILS_ENV=test
rake spec
